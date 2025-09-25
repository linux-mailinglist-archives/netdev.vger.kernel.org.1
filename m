Return-Path: <netdev+bounces-226560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20473BA1FEC
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 01:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BBE74103C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD92246BC5;
	Thu, 25 Sep 2025 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfcHsd5O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053354F81
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843989; cv=none; b=eSc/lyUBRQyjjLVdmZdui2hJnhfXrSG/wROH2Zauo04YPGK7RCjON5dkD8+l668dBTq1nPaDSjLhcBeNKq/w1i/nVZxHeo3zt0yK4J8pZ1FN+35OA8SiMJeA0wHp8NyeAdPsG6lS9jfTCPC4dI9QJ1o3MuAdGh+Z3fyHLZLxvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843989; c=relaxed/simple;
	bh=moIGVKSJv35h1eQY1Dqre3DNbBHiJRL/+W2+VxLIeS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvDwHHva8gciyUI0iGJynPeGhfLe59K19QQM1nsdv/x8eKnyTneQ9l+7PIUMHS9x+KznYfRIDnLWgBbNiacNTvAai+4RD5UV8kKjqpD9P0tVP5pxcz7qrR+j7NE062yZSv7atVw/UbCgpsKR2A3v7saf4XQUS5lsflxEawGH00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfcHsd5O; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4248b34fc8eso13870675ab.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758843987; x=1759448787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moIGVKSJv35h1eQY1Dqre3DNbBHiJRL/+W2+VxLIeS8=;
        b=ZfcHsd5OKQbITFINSzaO/90ch01Jj+hRq2KlQypoiGYwU9PmJ1wDF5bBoiH1BPS8Ep
         5RduM/FK++LdMzBNHz2BPB07jwMynTCetcGoE//wA2LORPfL8tTzlxPCCeUbFDqSP3WJ
         uUzC8gGFt3xAOssrxw80UspqL3Cxp5MC2+fjyS2qwgHHWllyvVSswaSwKZkxs1s2T7zj
         OlC+ES4lm7S+aJQkIuRfPup/bTwEhdDReQVMGFMEINj9q8jTjGei0Liep6vSKK00cNUw
         AcT4SusG6wF7kXcNCrKjy1qZyv3vn6ztva8vQLaU/a4DO0F639JPPYN2G8wPc3VYoKAM
         itCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843987; x=1759448787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moIGVKSJv35h1eQY1Dqre3DNbBHiJRL/+W2+VxLIeS8=;
        b=SQy/yZKXflI2I9iC0sFR6UpswAALhKSW2nz8MI9U+4QFVc1W5OXL96EAjaVu+ABX41
         QT5+Z3aSqfe2HHWlO+lbY5peTsSRGIj/WGp9f2Sjp5lQVz3Anlm7xIAMObGHsEFgMUo1
         7nSAiVSYqf4pSP7mo+O3pr3jxECdAppka1eiw20lfx2l27qgccZ1F0Zw8q6SYh6JWeyC
         6WXqGHzGwoBgX4bHpC9dN8cbKUktJu75Zv1ttlwfFAwBGsIVzn1A+LKYINIj56KhV+7o
         CH6tRS5yQksFw/dv705BY4d7C43H4V/iqe0yJ6/bBvWmn3A0Trz5KAzfGLliYeL4ydLw
         hm1g==
X-Forwarded-Encrypted: i=1; AJvYcCVLc09rBVDcbl2iUOLcX14jpgaxEXv9lDrTLGZwCTAdc5p+9G+vI5dz8tbT9M3xPWyecMfZsSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDWdASOuWKQoDYh7eqWB1IQ2oYZLQcyzltKmjKD6tm+0Elwqb3
	IPjp8GpyuMVyxPWaOqM6Uj7OmuQP03jldv3/U/mm6XuMWyL73ynYJAEL9N2AaSIFacHdEqVQ6Uh
	wcwVGmAuMcAs9978kiD9qIQX3RpJtCYc=
X-Gm-Gg: ASbGncuU+pb4w5RSNtfBm4fpZ7xwHFKl6wJ6ybj4MKlZ2zReRq026tRse/MmuJm0/gf
	WRXrC3UyFRCtJvk+giNiEdrz+eGW8GP3Qsh09Esz/ubfe5NZm1rXqer7hMzIDdZyaNVLT34iES3
	4upSX7RFpu6EuVD9zY8HFCCO7OdosApm3eRByAo3LB8tE9YT3JTmsmOVjjMPjTj6ry0hK3H89Vx
	Hg1FJM=
X-Google-Smtp-Source: AGHT+IHLqsE+3y/UsQQZBwtr5q1M0rDO1E+pId634vMyngEZ1jv+FbdsBt/YYib1qSYyyUGKOV3FLS6exLbDvkFNL/U=
X-Received: by 2002:a92:ca05:0:b0:427:47aa:2b52 with SMTP id
 e9e14a558f8ab-42747aa2b7dmr7776345ab.27.1758843986838; Thu, 25 Sep 2025
 16:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com> <20250925160009.2474816-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20250925160009.2474816-2-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 26 Sep 2025 07:45:50 +0800
X-Gm-Features: AS18NWDdH_cfRGCAWU3rjffBik6a-6UwrKWN2NTW7DrXIHmNTbrnVDl9daAFYts
Message-ID: <CAL+tcoCnaL_PBDqWrQzMbUXHfXk_DAYvZ46Zn2X9Pot8iShrOw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] xsk: avoid overwriting skb fields for
 multi-buffer traffic
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:00=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> We are unnecessarily setting a bunch of skb fields per each processed
> descriptor, which is redundant for fragmented frames.
>
> Let us set these respective members for first fragment only. To address
> both paths that we have within xsk_build_skb(), move assignments onto
> xsk_set_destructor_arg() and rename it to xsk_skb_init_misc().
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

