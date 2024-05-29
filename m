Return-Path: <netdev+bounces-99157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0018D3DBF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5F81C22061
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008B181D1A;
	Wed, 29 May 2024 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuicENAu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAD181CFD
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005066; cv=none; b=BDwGvnRjScTG17u/OtqBJvlaR7of1axp8A3wl9Eg8hQQGpwROTDROMQueIzwbPN8yEMkjJiUH/Yz4oiXRK45S4QC8OF+AfEEK7f2Fygzh9psTTK5k3tY1jm4hISfvPQbxp022AVCuTeTdz9K5GBN3clzCnwQXqov9QK3ituWa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005066; c=relaxed/simple;
	bh=iy8R8GcqhWZ4+AcXvqiKJKBYDxc8G8h47dkrhOzRDXY=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KsZ2gTP2N2ff/Mhm27Nvj4t41n2oGwBZ9KqPyl/XZWCpRvm0ifXKNA5hvoeNOwKcgp674zP7BC4k7Xv11an7gQ5XLkmmEbAq/zNJlYiFQD78GGvVnOAdxGvp+I6+ekVdlh7LBBI61ElIMfzIidgtNCupmDKfbbAkE2qpBlR85hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuicENAu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-351da5838fcso2266994f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717005064; x=1717609864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToBVjUBAYd5GLRFw90olVrpNHI7eEaGK9sd6sqA5ZpY=;
        b=UuicENAuaGl4uRiCbn2RsMPjeVNq3suN5G4YEuEO4DUzBV2uR5zSI3kjbNxvSB1ow+
         f8SQyBRizgwBmyn3z8qezQDxIhJoPptoSdM7P/AfohoS88x6sgKHmxJ15rgwDc4hTot8
         UUdu24fH2yRFMwHreOVeLa1AbD7a7vrFF/jwe0Fc3htPoJURkM7eTDDe2skJ885CFdQh
         X913Gd0Ubi+ah/7a1n/Pwf2X6/FlRKVx0OoG0j0HrgSEvYcUp6DP2xH1JhgoM7+wWkrV
         BObpBgmcznVJttP71XYrg8GrUHxMRo+zW7UmBaTWaTMiR0oxnp7ZTAV9VfB15CWeEoY4
         431A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717005064; x=1717609864;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToBVjUBAYd5GLRFw90olVrpNHI7eEaGK9sd6sqA5ZpY=;
        b=Kd8KuGHrOvo3W2uupM2yI5MNoptJPHRvmCdUo6+5JNuVCka/LcaEnAPPjJYa6QXJZq
         QCBD4jD0ZSsrI448QDL+4n6Bv4WyuuiNfbFfW0iTs3zggUKGRkgq9s/iP21kV1K3Ec4w
         c2+c+sh4EtroKQ2A4vf8RExebLr+L1TfJZFx3do0uKdWD5wZRmrAlJQ5u6OKS0KQBBZL
         SUCnwcSfmGzN4XxdHSohRD//M9jKenY3kdZNWzTt8KtQOwswhiGS9nYp6bUgfnauLLBz
         9HteXI+qpH5qrmDN7arqfnPmQmfQpgSn5ZAGdhMb6a66rF/Iy3C5RbwPksQclwuqLspO
         ez6g==
X-Forwarded-Encrypted: i=1; AJvYcCV0vDJsMql+iWsXui9e6Xb33JleKE65e3f5t+F1n7WH6MJg45wFojXMRlY4j7P+EGhVonLLsBLyyQcvQGD8aZAvLerWJTw8
X-Gm-Message-State: AOJu0YzlX1v2ILmYtFDjzZ1hNl2Ur5bt+JXTlTCKyKUW7WcyT7Cwph6t
	OL3T2gI2rTnC/gXfhF1XThr3Ev/8qF5eaa68EdCmIHM8gQWcgnjUWux2FQ==
X-Google-Smtp-Source: AGHT+IFKaZIg39gsX5oHbDZWRCeO33wTt7f0voWnfVDNuj734BHqAPpIq7auJdGDruzTbkRVUaMHTQ==
X-Received: by 2002:a5d:6d86:0:b0:357:ce05:7533 with SMTP id ffacd0b85a97d-357ce0575a7mr8564237f8f.40.1717005063392;
        Wed, 29 May 2024 10:51:03 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf0382sm15706096f8f.95.2024.05.29.10.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 10:51:03 -0700 (PDT)
Subject: Re: [PATCH v3] iproute2: color: default to dark background
To: Gedalya <gedalya@gedalya.net>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org
References: <E1s9tE4-00000006L4I-46tH@ws2.gedalya.net>
 <f8dc2692-6a17-431c-95de-ed32c0b82d59@kernel.org>
 <27cd8235-ac98-46dc-bac8-3a72697281d5@gedalya.net>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <d8b4ae7b-4759-06d0-9624-7edb93caa09f@gmail.com>
Date: Wed, 29 May 2024 18:51:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <27cd8235-ac98-46dc-bac8-3a72697281d5@gedalya.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 29/05/2024 17:36, Gedalya wrote:
> That's not possible.

Then in cases where the tool can't determine the answer, it
 should not be using colour at all unless explicitly instructed
 to do so, either on the command-line or in runtime
 configuration like dotfiles, /etc, or envvars.
"In the face of ambiguity, refuse the temptation to guess."[1]

> The fact remains that the code currently makes an
> assumption and I don't see why it is better than
> the other way around.

Because changing it would break it for people for whom it
 currently works.  That's a regression, and regressions are
 worse than existing bugs, ceteris paribus.
"Assess[ing] what is more common" won't change that.

-ed

[1]: https://peps.python.org/pep-0020/#the-zen-of-python

