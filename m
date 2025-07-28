Return-Path: <netdev+bounces-210639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030CBB141C3
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283AB162B66
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C2B221264;
	Mon, 28 Jul 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2WmjTozz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910D18FDBE
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726390; cv=none; b=WS+zeYTxnRP7piy34KuKUGFo5LIicJCgL13m1uNMm7bZr4oulkwux5GS6kDdriduRzNsPlPnhde0AqcwlXyySi7ICoG0J052j5bpxGJipoEe2tl8o6rVfudySNdmfnL8ctWcD8pfq/WNqtwf+QvXxZd7wI4LYIpCtDoAY9MECrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726390; c=relaxed/simple;
	bh=OlqEEkbvwte6AnCgyeLK/LWGj/oL1RODdyBWXYTL0KM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgY1riEOZX1nkV60YHsed+ShSNkQHSfRRaUzBkksybCNutNGVUG3661bcOcGwhVV82SyRomWBNmJtxS2eL9v8fZUq1kWShzV0ROySoGpeWZHtQbHzTl2iYfxfEHydgmJOl2c2S53A2B0c5hKOw+KYENIoUrKWhsM7yjxie9OT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2WmjTozz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab60e97cf8so58878661cf.0
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753726387; x=1754331187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTpC0yebuj/6W1UbrTwes2FGfVXy9HegcJDQSz0DLmU=;
        b=2WmjTozzsZQjQYbegGqcy07mIe4VviufA5AfI3lLZBXNGi7RxVp4xZvRlYsA80KS0M
         NUwMXZPdSytgTpsnqq6bRXgae5pxgDGc5u3eWgURAWMoBs3JG5cTcjrqCKb2PgKTkw1B
         PHJTMK7b4JXFKG9sXk5P/gsb0RVGB1MkkL+m1fRfTbIIvDklHOrPriPYTViTTTL0LzcE
         F1tblg027ZdtmF0SbGRLaFh6f2Uf7VLGtKP1qj4FXuDEICe1+OMPvrVmVPvhbgRkw1JT
         lR5cIi1J5yGROKva/PgDA0F6tCtNU+tyvq8U6hGJ0opunN6AEZfsVJJp5LN+n3iTtHos
         Mbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726387; x=1754331187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTpC0yebuj/6W1UbrTwes2FGfVXy9HegcJDQSz0DLmU=;
        b=GV3ne8e0LylrxI4un++g1EiEwG7tn8mjieAqejgG9tprWE5coTymzcZ8DnWdor6b7f
         ooFGnWq9FqUzQ49PZR4rKsw7Bykh4aL3OLFhC+nNw0IwVr12Fw9JaxAiQDghPjDQ+VD7
         fI0ACJVPDINhJiteGMNms+3bS2/LikKMJrh123YwCJvHudcXuXM3AAphefOl2etX0zr6
         w56ym7e/MflG7ntOVfpgC3x398CQhaieFlQC9Z5lShuxJGShmO86n70rk4F6T5VDioH0
         d7nB29VzHDr/H2RUK8dWW0qsjbn5QWJa8r6MfTGCwUvVeqsAgeFsWApF793xZt8eTwER
         D71A==
X-Forwarded-Encrypted: i=1; AJvYcCXKhpmhmF2jQ08CYitWRv9UeW8hop9EswJdIV2ZJ7EbEAktIqHQ/44cFTAVGtPTJIElGgty4VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzova79UIaRwU5NYwafRuNuPMOSi/ZtAtIAeS3Er6/1P4Tu9C1
	riik5PgtlEZwkO3Gz3AKQDALmNo9Od0RixJankUV0IEHGamqxSznG8ajNob/4dgDlDw=
X-Gm-Gg: ASbGncvb57XZIGI5U2LTl0T5VPNxLQApuY+kwPjxP1qLVuNxR6sXD3O1LRy5uyGc8Ms
	jVLm80Iqn+XdqzVJPmIdLRpjUXDlzMYJ+3svmYqPfHk6f5L0KXGBRa57ZjDWonBQ2ywJgAKJuLk
	WhcTMoSRitftdmBg4WtC4xTPE5lAI3Uu6Nl/096FwKhNmGdzup9r2P1gQQg0lLKKlesJn51FVSU
	6WIlai+Q4F8SLmUPClhh8vHyM2kmT8OJ7KyBR9mG6Ym3L3f+Bx5CDQPGZuL+1JvsuNxklrWMAGU
	kSjzpHk/S9VYJB0FdebNZRcxWacxkdeoOL9NvNBtrHvzBXbOdmQPKkcm1r6hxNdNUQU97gsX4dL
	WDIb1pnQ6xV2dbRncIEc4ONPuaJ9irG+vWGIYGGyL/lvJ3b5Wz6BTbr5SbUVo8RIpW7DkWqxC6J
	Q7vbHyDm7irw==
X-Google-Smtp-Source: AGHT+IEjLVd1/EiA8TbHwzh9av9MrUC97c8DtzNYcHm0kSuZZP1gLueDT4IMRyHPlgrecbcvRPio/A==
X-Received: by 2002:a05:622a:614:b0:4a9:af3b:dcfa with SMTP id d75a77b69052e-4ae8f1c62a2mr148187391cf.48.1753726387147;
        Mon, 28 Jul 2025 11:13:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9966c3cfsm37037221cf.48.2025.07.28.11.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:13:07 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:13:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: dsahern@gmail.com, netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 ernis@microsoft.com
Subject: Re: [PATCH iproute2-next] iproute2: Add 'netshaper' command to 'ip
 link' for netdev shaping
Message-ID: <20250728111303.301f61f2@hermes.local>
In-Reply-To: <1753694099-14792-1-git-send-email-ernis@linux.microsoft.com>
References: <1753694099-14792-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 02:14:59 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> +
> +static void print_netshaper_attrs(struct nlmsghdr *answer)
> +{
> +	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
> +	int len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
> +	struct rtattr *tb[NET_SHAPER_A_MAX + 1] = {};
> +	__u32 speed_bps, speed_mbps;
> +	int ifindex;
> +
> +	parse_rtattr(tb, NET_SHAPER_A_MAX, (struct rtattr *)((char *)ghdr + GENL_HDRLEN), len);
> +
> +	for (int i = 1; i <= NET_SHAPER_A_MAX; ++i) {
> +		if (!tb[i])
> +			continue;
> +		switch (i) {
> +		case NET_SHAPER_A_BW_MAX:
> +		speed_bps = rta_getattr_u32(tb[i]);
> +		speed_mbps = (speed_bps / 1000000);
> +		print_uint(PRINT_ANY, "speed", "Current speed (Mbps): %u\n", speed_mbps);
> +		break;
> +		case NET_SHAPER_A_IFINDEX:
> +		ifindex = rta_getattr_u32(tb[i]);
> +		print_string(PRINT_ANY, "dev", "Device Name: %s\n", ll_index_to_name(ifindex));

The display in print is supposed to correlate with command line args.
Use color for devices if possible.

> +		break;
> +		default:
> +		break;
> +		}
> +	}
> +}

Indentation is a mess.

Iproute2 uses kernel coding style.
Suggest using a tool like clang-format to fix.

