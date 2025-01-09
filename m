Return-Path: <netdev+bounces-156675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE39A075AC
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DF2188B44E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E7F217641;
	Thu,  9 Jan 2025 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ8WKZDK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9F20551B;
	Thu,  9 Jan 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425403; cv=none; b=kcr7JFNmdWv2y4DdtI7Au9wuFGnPZWf95hqendXHtJbQlDd8RLNTEZVn3usdpD13WlSNslncm0SzR7MVcEacY7yQki9/HTiM/qIBFCi4jTsz98r4DNrDzY3tOFJC70jWAygtb+PtogMSg1JMxaqU/wvKFFCAiUWDxySjcJOY6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425403; c=relaxed/simple;
	bh=WKEaDlzHJnTsoJs9OpNYkFEiipKOXlfflYE+8TYUNHA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=SmGiyiCmCjGKZO3dYbTUjDjc3RN5k2dFkYlYv+JKm72YnQs3ga+ToNUuTa+LebpbSOAwW2fDmFBtAZ4LnbPFVRxis9ggx/8YXdsdZTDxYvYAcUvsODbxsADRIHqmuSsGbj3Knp74ycYETrebGDfUP6tGaRgvSDrMH0V+9GnpNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ8WKZDK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3863494591bso461216f8f.1;
        Thu, 09 Jan 2025 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736425399; x=1737030199; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WE6LPyrGRltfhXMKoN4nkqD77PNtIn7bXA/hoAUj5dQ=;
        b=SJ8WKZDK5BX6JXqv99xy3K0HO6W0gvXFP9pMqI3WdtciMLYwgEqpsiji5htQbLsDGN
         kd4Nvc8givCE6ahu+/KZy8K1hHItT0uSPZ+5vdHMO4ecU1uDFFGvdN3PmPFpBiCFYoe2
         qN7yRlBnNPwC7KziM8lUYJKpBpqaKTnHWUxxPozs2ZpExwI5GtWb31B1gCWMou+xFELJ
         YLn4AMjDJRXDwW93EqWVTV+q3/HSfaxI1bdkG/l6NayfsilDhi4T9h6HGsfWvi5Lr/b6
         4pKGPEz1bemMRnDA8eVeZxZGGLPu7LD3EPTEHB41g3BV4QVLGoyO5Kk0C2yIGiX/m96V
         86cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736425399; x=1737030199;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE6LPyrGRltfhXMKoN4nkqD77PNtIn7bXA/hoAUj5dQ=;
        b=cCDnOTNRuGTUhkUrbQmmgHThRO1sN0V/SM8fQreXOzhcLcBZkcrUKbjebJp7C8qE9H
         Lkti4OvhND56WEtwtccfK342x3OXiETVN5iHfI0q3pxdlnrSYUEwr2TMhJnnNq2dMTlj
         nHfpCMfuMDVYE5fImToW3trvgQf9Lslz0sZPZsD86QV/uMR+Q5yj5CFmJ8ntCzHOgTF6
         DTe1hFOJe/cmtni8yvBmQcRM/pXOhOO108lLPKnMsOvP/8OV3SaQdBqxPaY1gCb43HlY
         XUxHOS8PkmRT0dwlXS0b4EVw702KFFCdd7Izgc3ngomqIPiQwJOC32TWu7vEhkbYnFDZ
         QAPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLb/bA48CFKzA2LJvt4T5EpgbnKm3yCobDCIPafvnEnLokMoS+XZofmm0Lt15lj/4lkok1K+3x@vger.kernel.org, AJvYcCXpsH/G/GWM77VgUZX3hKRGPnDlsDwfEtk6bL4Kcw85LMkL+VOD1QzCOmcWfey6LdJ2spoaryAZuqLrZ5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKxm2p2nSkDfkb+lTYRVs2ad4qHAHodeyoZXkvDyZT6VNoxfM
	ef0s2CAcCDf5fFhPgUGAxi6XZIsW4Yog1VKTgacSQnbJDtNPjEtRbaZhkQ==
X-Gm-Gg: ASbGnctJhJn0RUhl2886gbz8BH1OzUAIi20RNBk/2cywEvf7NX/U2lwmX038v1uyFNH
	qxXa/KmFJ2EAOH2szz7KBEhOeEnCqgziesPgzK7lUZrHnsmmFIqw4TM9PuObms2SmsNSLaAup50
	m3rsXgu11O3bzL39PG5NsMR1TOKWPwBerk2T7/VH1d7lPDILFqyCimNttrEEcQNKCvDF/MDE0Z6
	dsz+HPH+we6sbyiNVcr4RNA9MB/+CHjWsA6FqSALoBIVgsme1/VvYQz582WpVYMWyJILQ==
X-Google-Smtp-Source: AGHT+IEDzkEjt6Vqd+CguQByd6QQ8gbv5rTgMCU/HxEALK+dtsNWLRLRs7aQuCHniZYlTLTi06LmTA==
X-Received: by 2002:a5d:6da1:0:b0:385:dc45:ea06 with SMTP id ffacd0b85a97d-38a872deb27mr5726352f8f.13.1736425399236;
        Thu, 09 Jan 2025 04:23:19 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:1cd4:f10c:6f67:2480])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1bebsm1686665f8f.95.2025.01.09.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 04:23:18 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: stfomichev@gmail.com,  kuba@kernel.org,  jdamato@fastly.com,
  pabeni@redhat.com,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] tools: ynl: add initial pyproject.toml for
 packaging
In-Reply-To: <b184b43340f08aef97387bfd7f2b2cd9b015c343.1736343575.git.jstancek@redhat.com>
	(Jan Stancek's message of "Wed, 8 Jan 2025 14:56:15 +0100")
Date: Thu, 09 Jan 2025 12:13:14 +0000
Message-ID: <m2bjwgmbhh.fsf@gmail.com>
References: <cover.1736343575.git.jstancek@redhat.com>
	<b184b43340f08aef97387bfd7f2b2cd9b015c343.1736343575.git.jstancek@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Stancek <jstancek@redhat.com> writes:

> Add pyproject.toml and define authors, dependencies and
> user-facing scripts. This will be used later by pip to
> install python code.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

The ynl-ethtool script is broken when installed because it hard-codes
spec and schema paths to in-tree locations.  I'd be happy to fix that in
a followup patch, since I have a schema lookup patch in progress.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
>  tools/net/ynl/pyproject.toml | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 tools/net/ynl/pyproject.toml
>
> diff --git a/tools/net/ynl/pyproject.toml b/tools/net/ynl/pyproject.toml
> new file mode 100644
> index 000000000000..a81d8779b0e0
> --- /dev/null
> +++ b/tools/net/ynl/pyproject.toml
> @@ -0,0 +1,24 @@
> +[build-system]
> +requires = ["setuptools>=61.0"]
> +build-backend = "setuptools.build_meta"
> +
> +[project]
> +name = "pyynl"
> +authors = [
> +    {name = "Donald Hunter", email = "donald.hunter@gmail.com"},
> +    {name = "Jakub Kicinski", email = "kuba@kernel.org"},
> +]
> +description = "yaml netlink (ynl)"
> +version = "0.0.1"
> +requires-python = ">=3.9"
> +dependencies = [
> +    "pyyaml==6.*",
> +    "jsonschema==4.*"
> +]
> +
> +[tool.setuptools.packages.find]
> +include = ["pyynl", "pyynl.lib"]
> +
> +[project.scripts]
> +ynl = "pyynl.cli:main"
> +ynl-ethtool = "pyynl.ethtool:main"

