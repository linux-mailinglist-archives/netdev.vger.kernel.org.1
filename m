Return-Path: <netdev+bounces-75299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72F48690C8
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585D0284486
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58AC135A71;
	Tue, 27 Feb 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BaCVAiGv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479721EA7A
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037778; cv=none; b=K4VAO6salQKXeFzUrOrD1UWBEDoZzmGaGA7t7W+XIm78OrcpR+Q2d5/yQH4LhQojs6mwKHaE/1ljZamZjkz6OBBbGUZVeoEmOxqHQz6UEEicvQp8YHuaijQXrs2i9uzachyFXQVYAftBx8mnTgEkz33TsMo1j4hbUu9H7Wi2CsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037778; c=relaxed/simple;
	bh=VNeOIODn7VDKRBRn5R4i4LVYEfcQgwzTDiEhy7JuRuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyP7u17rACaJ9D0dVs2zd3MPWLUC7kYr3xkCH1e77bQqIrL+sPhbyh9mJCWSa5rQJINHvJ4xvhqGZhSen4Etysw8Xgc7AlTxcAHm00lWNHgxhDOIFsd0vWZ9bL3+trF0lGUEH3WJPovscH27ktJ2MglacLJZ6355aXFP/Ket1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BaCVAiGv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so582365666b.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 04:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709037775; x=1709642575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNeOIODn7VDKRBRn5R4i4LVYEfcQgwzTDiEhy7JuRuM=;
        b=BaCVAiGvVWQ1EwgM254btSCFbxeJIZf5J/5D7tcjxLPLEcJsbO6UShGmoEANFBHYhp
         ZLMUMA2fUB30R70woEwX0T8BbvonXt6RAympPtQ0PEaeCX0NCzU7jTpRK5faQ+oRCa6X
         wfLrs61Ikw0gRJ/TlrnPIxHQsevxvaM4OqmafdgM3ZMahk+lSADB/rZ+BHFOl0b5+BQh
         HKE0JF0NdCGGjtVEGizr9nfyPNyXPko9H6XoTZa64XyL7jLh4F+oMd7fxwUuvMVPD8ld
         J6MIgt+xZXQ9oLo7sTDjTklr9gAPaeQjs3LSn4GmoivZaOK7hCNqyrZtxLmz7Krb948c
         6q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037775; x=1709642575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNeOIODn7VDKRBRn5R4i4LVYEfcQgwzTDiEhy7JuRuM=;
        b=KrUWIydIKiHJjxn5hbwHDK7xaHLEfrWq38oa/jigKuqj74+AjPUXKfjvLzd8Sp3NJM
         +9VJC2hoPVqbBrhtJerMrhU7ZKyogWJwSNeBAL7+zi+wORwwE+YzWzNNfwzxans1XgXD
         QpbJIfT8dnTVuxt1MBEwnxcawQCdYPT5XPNIKQJteq/OmG9yCJFmzFvvfTW4mReJQH5E
         tB0eZCukXT7x15vRUp3OmMlqXu7aj9G9foGGaTCjtIeXvtErnNk0G1dYRUK6FWyX1U1v
         wCabPI/qR4gMLCJa+kFN3lkSvKryirt6tHMeXs/v9sLGnr8h4AMd0ns9o6JcqfS9drvz
         ioSg==
X-Gm-Message-State: AOJu0YwHQPRES0PLwKPE5v8ynlEzG7ltarKs+76lnNgLoo5VFdFXYEyc
	rWKHC+T5kCzJO6HXDQSxNhI4/hId2lhQS+SuhxHasjmc3C9xRwOvGT5qA4lh9q0=
X-Google-Smtp-Source: AGHT+IFFe+nUVUhX+MMWNH2IJun8mSZ0et2RQYBeYfLf/75PPrwHyIDDQoIOAHjyxvm3DUikHd3MiQ==
X-Received: by 2002:a17:906:f144:b0:a43:3f37:4d94 with SMTP id gw4-20020a170906f14400b00a433f374d94mr4254318ejb.16.1709037775705;
        Tue, 27 Feb 2024 04:42:55 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a19-20020a170906469300b00a431fca6a2esm741474ejr.37.2024.02.27.04.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:42:55 -0800 (PST)
Date: Tue, 27 Feb 2024 13:42:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com
Subject: Re: [net-next PatchV3] octeontx2-pf: Add support to read eeprom
 information
Message-ID: <Zd3YzNCsTIBzjAjB@nanopsycho>
References: <20240227084722.27110-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227084722.27110-1-hkelam@marvell.com>

Tue, Feb 27, 2024 at 09:47:22AM CET, hkelam@marvell.com wrote:
>Add support to read/decode EEPROM module information using ethtool.
>Usage: ethtool -m <interface>
>
>Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
>Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

