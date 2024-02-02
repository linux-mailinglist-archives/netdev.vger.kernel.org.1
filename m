Return-Path: <netdev+bounces-68554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDD2847296
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642611C27632
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC07145B29;
	Fri,  2 Feb 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMuhl6K7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A7145341
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886348; cv=none; b=sTMRYLYw9wQHWah1fe47lKghmQAH9mjoGZ6/Ql1/GUDZE3lhSe7Ukc6MGyXqQIpG2qzE9pnXmznnLNKETgp8R+FpIfhDw8Zhu94LvfvrTb//0AGjSra2ZZ82rMy6ErExpRrQdp4yvZnJmHrjnp6UC6KgBRaAjevKlBjVpFwD6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886348; c=relaxed/simple;
	bh=07cHh0iUQrmJXAFLPrs9IeofxrQdEBqV67Ty6E8raY8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=JTKi/fwiamAYcZTQV8Ul4qFrjVEaE8QGOTFviJ60UQg4uhysk/uYUSqVzTp6EHQIYjIPtpBL+EFPnnzvkFYrdipmkUMeSDdlpsVY7UGagpKUOiQz7Aq9ZZGUqtiWWxi88UHSLYSQdnYu+CQ0r3Uh0Zea76hcnkai6Nh7oRGMOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMuhl6K7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so1606122f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 07:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886345; x=1707491145; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwWDYftar9qk+Ofb7Npj2nk3Bgn/Kk+awa6cA9G9Ef4=;
        b=XMuhl6K7VnnEzjr5Z8bUqnZnzvNBVaFH+N1mt4seNMgmhILi858SZpcEXLdgxO/ZJt
         OkTCtnBsaCHkWVAETzj6hV1Y4EC0TDgnMozvJO+eCAGKncQ4rL9hYBMu7TfAESpj9XG0
         qssk6OKkmGnenYR2OlQlNI55jsfAZtEJOBe6P/bOt7dlqZiw2NTxENH74umZ40x38BhS
         WwJ2Z6r3XTb6lKr4vz2wUfAHyUjplOZcGf6piTTHJbBjmsjkzcrfCmi4zDHgfdDFbuhs
         dQGb20oUCqyfwHuDZZuYSQ6rRwUaNW0AR9inFMX7I107SHdZh60rVvIyPX6ExbkMekqp
         py+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886345; x=1707491145;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwWDYftar9qk+Ofb7Npj2nk3Bgn/Kk+awa6cA9G9Ef4=;
        b=UVOjl3M6e7bmjmzLaUoF2eKXUAcGezq/rfKTsVMw+utVDzgGPn3RpsWD4OAdeQrvBr
         79KaiyrKo7xceI9kn7VCqLZgPBAYCDb1gU4dOnVobQl1oRTjGMWBLD8kZsNLv5MS4J9R
         0dd4Khct0g+Pm0w6U+fKUmDSflDS3mM7I56qor76gpvja+iJaM7m5V0T/txMuGquYq+x
         uO19lJ5PaXT3lSgGRqcWSaYRxyW2apEc+GNiI6UgYvlewW3FgIRkdS/PCAaB3YNydmQl
         1sVINJVE6YnqOJ1r/sNlEGORLUMDkbTyV2RzKaQmhoucmUtng6llcG7Z+Ukpcq3xJ3tv
         8v8g==
X-Gm-Message-State: AOJu0Yy6sLhxTZ8Y/T0GWx8DhSJ3cxdE9L99LpIOeKcKEvm7wjDVi0v1
	aRkNjs951OtotGa4JXwj6Zc8vIeeOeiRPdM6LYalZJVn1irqWrpNEGQGM0juIdU=
X-Google-Smtp-Source: AGHT+IF9tYpJgJRMn68aeVooDyhBRJYf1v3FTdET/yow8jzY574YoIvlOzI6vkbeEsiXLGXyQw6/pQ==
X-Received: by 2002:adf:9b94:0:b0:33a:e4de:9afc with SMTP id d20-20020adf9b94000000b0033ae4de9afcmr4063426wrc.46.1706886344801;
        Fri, 02 Feb 2024 07:05:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX/NKEX17Bjv2YSTb8YRXwDQe2pWBdeph7R893rQuflVKyEAQb0AFDxAapIbyqWcWUkgFzY4zFQYFR8wT2lYz6W/aR+QF+91zKrrnxwckpJD97l+1Z0k0T9DeVpOnMzQENOMQfD7wXLPMLOXCEQ4/Bhl6ILtbqD/EXytuPv0DfcHEuSdMkd1pUXJw7q1pmkrVEJ8TuLq8/QoUvbmmu7GYMmwp9oxOo6GD7qDeG3aNua8wgdslu5inwoj4zssYehPPj+OK/kdfBVrp7ziXM1LtzWZ92G6nVnDU1zEexnS5ASRuUD8HwIYK8=
Received: from imac ([2a02:8010:60a0:0:699e:106b:b80c:c3f0])
        by smtp.gmail.com with ESMTPSA id p18-20020a5d4e12000000b0033afcb5b5d2sm2106477wrt.80.2024.02.02.07.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:05:44 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  sdf@google.com,  chuck.lever@oracle.com,
  lorenzo@kernel.org,  jacob.e.keller@intel.com,  jiri@resnulli.us,
  netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/3] tools: ynl: add support for encoding
 multi-attr
In-Reply-To: <9399f6f7bda6c845194419952dfbcf0d42142652.1706882196.git.alessandromarcolini99@gmail.com>
	(Alessandro Marcolini's message of "Fri, 2 Feb 2024 15:00:05 +0100")
Date: Fri, 02 Feb 2024 14:34:51 +0000
Message-ID: <m2y1c3szn8.fsf@gmail.com>
References: <cover.1706882196.git.alessandromarcolini99@gmail.com>
	<9399f6f7bda6c845194419952dfbcf0d42142652.1706882196.git.alessandromarcolini99@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:

> Multi-attr elements could not be encoded because of missing logic in the
> ynl code. Enable encoding of these attributes by checking if the
> attribute is a multi-attr and if the value to be processed is a list.
>
> This has been tested both with the taprio and ets qdisc which contain
> this kind of attributes.
>
> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
>  tools/net/ynl/lib/ynl.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 0f4193cc2e3b..d5779d023b10 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -444,6 +444,11 @@ class YnlFamily(SpecFamily):
>          except KeyError:
>              raise Exception(f"Space '{space}' has no attribute '{name}'")
>          nl_type = attr.value
> +        if attr.is_multi and isinstance(value, list):
> +            attr_payload = b''
> +            for subvalue in value:
> +                attr_payload += self._add_attr(space, name, subvalue, search_attrs)
> +            return attr_payload
>          if attr["type"] == 'nest':
>              nl_type |= Netlink.NLA_F_NESTED
>              attr_payload = b''

