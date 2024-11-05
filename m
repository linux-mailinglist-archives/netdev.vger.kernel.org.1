Return-Path: <netdev+bounces-142040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AED949BD285
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367ED1F22E67
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789BD1D90A4;
	Tue,  5 Nov 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PbeTKL07"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98F17C7CE
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824683; cv=none; b=YDxCfWSO/sGQK2lNGYc5CeD/vLjqiiPMPz3d/MFuto5tyzvAcyiOwbZeEGfvm9tC0u+Vz3KRmArLze9ur3BK1aeNhAJkSBJRRsppR08gWYMLEewOOVkaXeOlqr9TnOrqT55RVpHeF4H7vVXVqt1EQq0RE28jvNzcuXLUHwZK/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824683; c=relaxed/simple;
	bh=UPG74iaw03x8PRm0dgzbZb+xiF4olBPTv0VLsJp9BrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDAGb0DQ5HYCUcSoHbF5KLwzemGcamISaygpb0etQUypZ/pzqMc+tyhrCQpGPDj/lhjw99FuHAZZFkWohkKedfFFpiVLR5BubYCunXmkaaXtZKG1eYvylDVzlUEI/JIRBVXme+hUk0uefCCGchns6vdUSZAjga+awv3GS9NsC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PbeTKL07; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso980236566b.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730824679; x=1731429479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUEePHhzip2qYreLmdf4/2hJkUby3Nwn2S52dXJDtZo=;
        b=PbeTKL073V+NATs3/A9c7aIcno5rR+dDGrhkseH8MdMAbJC4ZIFLItDKI/4BaFYOkn
         ZysKOqG3eDCts72ymJvr/G6wbpr0gDZsjT2vs4Yvwhpb4VkgyyqdIVGPP4ewBq+sBZkF
         G5te0qBnqX7z2oz3bjWXwZydsb8dAZtdF+TJKoVxffhPmz020HPIfTCi3AQwfDa+JwRZ
         AlkkjDQnXi07t/vZ1rOt+nbHZ04wLNaTNi7735KDxIXE4F0MzN9ufoirVTJ1UUwuDm+/
         s28QBqE6nA+x+pYg/rRbS6HnfXwD4JYkxcA/5jMkl9hBP7kqUiXFMdqnEz9sZ6dNamn8
         69EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730824679; x=1731429479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUEePHhzip2qYreLmdf4/2hJkUby3Nwn2S52dXJDtZo=;
        b=GsuVtsldxTuUMpNVTqyhGAsxg//HG9skcZr2ZNWZYYHP2eIDN9Mkkmr00j0CbhD4ws
         nq9Q4YU1fOHZtXgqnKkIFhTPZM8DNJY650S1h7o1SjA0fa2iqqnits7+eiwPZ+jSaVge
         tiE6Q/zec0DuezOcovdW7fX56/HW6TwBKYMfFQnE0j51RckSglVJ+Nq7fqxSdHPX9MDX
         3wAqCNpqlF619M/w2pcu/lm8S87po/nPKYxtKVEd3/BW+vdjnUATY8kIszcROfxHmCFl
         bN5ib5JeEcQpxmC7dRwTkJCBYXDuFH5wKKc+5JG4xSGKc5id4i1uzpCa5h/y4zFq236a
         uiCA==
X-Forwarded-Encrypted: i=1; AJvYcCWINWaC/dr/LsvLIIawh+D2MK8Tm/vqo2UVefmp9Q5KxTePnmPYbtOoYPDum8Pg4B291SHowiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69shoZykTDH9yKVgJ3AcqW+TRPtTFpMWEkGiGRX76EC0rbnLx
	zbxyez4zHbDumLFiueXSOwXMa5pbCx38FNDr3ZtcoXGQIy6V86SnRd2Rz60cZUA=
X-Google-Smtp-Source: AGHT+IG+KxFLAR0AN9YcgxLFtld6q5VPRj8YAKWGs178AyrLxQ0OcOk3eUVjRWsZWWXJmrtI1lvZDw==
X-Received: by 2002:a17:907:e6cb:b0:a9e:b0a3:db75 with SMTP id a640c23a62f3a-a9eb0a41a10mr331603966b.35.1730824678803;
        Tue, 05 Nov 2024 08:37:58 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f9b6dsm155109066b.158.2024.11.05.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:37:58 -0800 (PST)
Date: Tue, 5 Nov 2024 17:37:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <ZypJ4ZnR0JkPedNz@nanopsycho.orion>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105094823.2403806-1-dmantipov@yandex.ru>

Tue, Nov 05, 2024 at 10:48:23AM CET, dmantipov@yandex.ru wrote:
>Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
>new skb, I assume that the same should be done for an initial one

It is odd to write "I assume" for fix like this. You should know for
sure, don't you?


>in 'j1939_session_new()' just to avoid refcount underflow.
>
>Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
>Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
>Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>---
>v2: resend after hitting skb refcount underflow once again when looking
>around https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
>---
> net/can/j1939/transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
>index 319f47df3330..95f7a7e65a73 100644
>--- a/net/can/j1939/transport.c
>+++ b/net/can/j1939/transport.c
>@@ -1505,7 +1505,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
> 	session->state = J1939_SESSION_NEW;
> 
> 	skb_queue_head_init(&session->skb_queue);
>-	skb_queue_tail(&session->skb_queue, skb);
>+	skb_queue_tail(&session->skb_queue, skb_get(skb));
> 
> 	skcb = j1939_skb_to_cb(skb);
> 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
>-- 
>2.47.0
>
>

