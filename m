Return-Path: <netdev+bounces-111759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C563393277D
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CBF284242
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545719AD78;
	Tue, 16 Jul 2024 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="F8LdvZFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67D4C7C
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136592; cv=none; b=i7ZuSsv47kNVN1FUkb/bOqq61jKJmRzBXeu3U6oXJ9+v1oXdGN2iGJeWv3UekGvrfyjoOoZiF3PxQ/OAuKPexyxaONaMPalPflSnMgnipRjdFoJjCE5phBC4hjO+iULIFYyn2z1pXcH4YHUpbep5eo6uPBXzGdTAL5bxKbkLIYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136592; c=relaxed/simple;
	bh=/ft0t505pKh6jWEQYbOIW4grW201GD1N6QXAe49ok8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmVXIGNvPs6xvbHDQ8tmFf+gnZ2W3NyFfhcjuelBXgoIgd+izdeAbg6GMOItfUp8U3kkTcm0eKoV40GT+o+ThpJEkD/5JoL6jk+QzCZUNXZHBVGrCZdUUoHJLpFJnd0mptNIDS7A1GiCFIq2gikBn6fJqnJ/AZtOudjbukouNVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=F8LdvZFX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266f344091so40195095e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721136588; x=1721741388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ft0t505pKh6jWEQYbOIW4grW201GD1N6QXAe49ok8M=;
        b=F8LdvZFXVb5rH1fq8zcOXEASi2mq5wUiGVw0rIAQujeWdtwyC3IZSnNM7sVsSwnWbz
         sA4QZztmP9DEZSBRqY9V1lu0UpBDP6gBt5+kt9tzGaSo2EVpL8O+31WHdDBoYX/flRN/
         vu308suxdFj/gRRvu2GT9VkECnVLiXn3YUb1LqZTGJC2ZeOXiizPQXDQgWz9fraQSoqY
         LlrFUAEoGXwjrhoGacddcyzDUup1tV1F/aad90YyIkzlvYSoUF2kl3xWyvo0c7sv9yYE
         DEP3hz9YFH8jtSQ3UVPQgtLZWFwGJ1kPk8vp/wL/UY+ilzkZdIpwJPYBCJ9sq56HhYG6
         RQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136588; x=1721741388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ft0t505pKh6jWEQYbOIW4grW201GD1N6QXAe49ok8M=;
        b=ncL2kS4OTz1BaWu/Ays7HQILamgN01EUPwpU7YeBIU65u2lZKVKYjZdy2ziNeGpFdl
         Ya9tG7q4mS67zGVf/mfaJzSkaLHuKBpwOe/sEvw6lm8LKtuyr9nlZD6WJEJmA4HfuT++
         z2O7HCdBc3G/ARy3hJmhEOAJrtTQcoxVxcdryWPBBMroa7X/4q07s7ycvvN67hduTOrN
         hyqa10sZu2aoh7xBcIKzLp9C6BVv/V2EVmB6uUCcT0rW0W+LBCNFypMuO4kl6a2nsJHz
         9s0Aj594zmC/6XHv1HpHE1+uelWOmzgxJdtTGRkbx/CiUP2E4+SfVT1rN7iWduxtzZRE
         LO1w==
X-Gm-Message-State: AOJu0YwaZmUTVUr5q3TuLnMEOjCqbid1bknE8LGDoPPa2XJtA2mfUZ7Q
	S3/Qbps+CEbou8ETxTgPP6HeBj9sxtwUorfyMC8q+UxKMCYWfVdsQVU0JDBR/V4=
X-Google-Smtp-Source: AGHT+IGjAdQSxeEVdVw57jLUmBg/hDy2vsxlmLGLre5Ls8iiK8GxsJXzSOiFfxaji1YIcSK/8TzunQ==
X-Received: by 2002:a05:600c:314a:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-427ba642ff1mr14447565e9.16.1721136588514;
        Tue, 16 Jul 2024 06:29:48 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef57aesm124210045e9.45.2024.07.16.06.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:29:48 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:29:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Jakub Kicinski <kuba@kernel.org>, Kevin Hao <haokexin@gmail.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pktgen: Use seq_putc() in pktgen_if_show()
Message-ID: <ZpZ1yOkas39bIsWa@nanopsycho.orion>
References: <cc21bbb8-e6d3-4670-9d39-f5db0f27f8ce@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc21bbb8-e6d3-4670-9d39-f5db0f27f8ce@web.de>

Sun, Jul 14, 2024 at 08:34:14PM CEST, Markus.Elfring@web.de wrote:
>From: Markus Elfring <elfring@users.sourceforge.net>
>Date: Sun, 14 Jul 2024 20:23:49 +0200
>
>Single line breaks should be put into a sequence.
>Thus use the corresponding function “seq_putc”.
>
>This issue was transformed by using the Coccinelle software.
>
>Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

