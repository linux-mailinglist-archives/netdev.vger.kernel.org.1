Return-Path: <netdev+bounces-94431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8D8BF73A
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C571F2151B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC77D2BD00;
	Wed,  8 May 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpiyyIHj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B52C84F
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154071; cv=none; b=H6bkDPx4ynrHKeDJy9ZhmKoRkqOhSn9M2Cw0wXfaRGm7mg9ag17M11BLP+0gyCqknguBImhTJER6RrKGUt23rsfBv6XsoRHOswvh05QjXHVIJEOaRq+ltF3FDuAShjPTUCde7fwn3JAOaIZL1pzDj5CMLmYEHy+TWjYn3jI5i2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154071; c=relaxed/simple;
	bh=GyGJWYGjWNWWlZA2nur9d6MTw0DiRhUztpnXKngeLGk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P60IoocxYQ2NXKInUxTJoUOIN21YkqA49x9BDHUhpAkvNM4DYorjxKrf38s4oRG9IlaAIHzN+hhBeKUUIF3pYFNi9ikeI8dagZJAlQX+JYJC9ll//SH2iDlASLE99Wug4mtBCIncsZsMXp5t6tTfCS14QQNuYVznkZexCCbqyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpiyyIHj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b59b993389so525221a91.3
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715154070; x=1715758870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipJq3xkIr/xjftBMvxCwJovPj8qxntuxIM/1Y4aR+F0=;
        b=DpiyyIHjgUkXr8FpxGSDHm7LeeSR8Df2pi5mG9YaxFSC61mKBnvwmwd0sQvIk8O3yc
         5Dh7AHzw49XwZBLUsfRllXWlJQqfXlpK3hvdI1nWwFIpcBqVnENtF5dLHSDmUJAtVd0c
         caEB+55zhtGJuyNBFXnnkTdQBMMbcX5ArFuZSpenPmcRyn3ve80EEpSJ60FG53rrLN2H
         UzA788sklO6kYUb4kdEKOaRPBFUCWzEKgCAqSUfhR/d/Chv0rtWndFBmKX680ai39uPF
         YDL6Jhv9q4LwyNTPB5pV0R6LoH5hzUTfmjkBXFp6j+uV/Uv86L63N43vA28PUXRcLtgM
         3QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154070; x=1715758870;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ipJq3xkIr/xjftBMvxCwJovPj8qxntuxIM/1Y4aR+F0=;
        b=WH654o1t8FW5ic0DAyRroLTFOMW0/HYZw+vAMTgH5iyxCU3MK6aLoLdpmKXFyf10Y8
         ZkSS0LqyCmGirxSoTad87BZunOOPHHBFNukCmlsX5N2eY5CZgNBZIqsE5fi9LirulUPL
         U3musyJASN0eLwK6F8B9UGzXSD9CVjHH0q6I7UY7JUhAeIPoqAVJnMaQnscve7XVJgxB
         TvCbf22cbl0hjSaq4FZiAlA5JN0GpklcO/8NLLHxhkayLT5lSba8TamnwMWJtpO21XWa
         9kzGZGJFnH9R4Hjmkoa2q13FJD6HqIem95EpYcadvtFJYOOcc6uyl9gYfGjs55p0YQ7C
         8K6w==
X-Forwarded-Encrypted: i=1; AJvYcCX/eRtFTd9O1oqBC5FAbnO0yZ+AurMzeCAGqrfRGfcw9EeAz5ORCsVzcSo+yUqfKGt7HLZKQwn3DlqS2F++9yFdIQTJ8n3e
X-Gm-Message-State: AOJu0YzFYnz6Yc0O8mMm9GHqcfP2+o9NZu5RUXRDX56G1EhBtnKkUa75
	4QjjsWMDoTZPE4MnhSC/bPPOnwq2DlZ6XvDVPtWOWpFOIXizYN0gBG1Kw7ae
X-Google-Smtp-Source: AGHT+IFI7l38ZqgJZZu+/Tio61EVVUaBgt5gzsSGjbs7L9Qxko8JRx+9vEXYObRE2ABu7mncpvJDOg==
X-Received: by 2002:a17:90a:d392:b0:2b5:1cdc:9ac8 with SMTP id 98e67ed59e1d1-2b616bf5342mr1769777a91.4.1715154069674;
        Wed, 08 May 2024 00:41:09 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886cf36sm781019a91.30.2024.05.08.00.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:41:09 -0700 (PDT)
Date: Wed, 08 May 2024 16:41:03 +0900 (JST)
Message-Id: <20240508.164103.576236960882944609.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v4 3/6] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240506185129.7c904763@kernel.org>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	<20240501230552.53185-4-fujita.tomonori@gmail.com>
	<20240506185129.7c904763@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 6 May 2024 18:51:29 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu,  2 May 2024 08:05:49 +0900 FUJITA Tomonori wrote:
>> +	err = tn40_tx_map_skb(priv, skb, txdd, &pkt_len);
>> +	if (err) {
>> +		dev_kfree_skb(skb);
>> +		return NETDEV_TX_OK;
> 
> make sure you always count drops

Fixed.


>> +	.ndo_get_stats = tn40_get_stats,
> 
> ndo_get_stats64 is the standard these days

Fixed. I'll work on hardware stats support after merged (seems that
some firmware versions support hw stats).


>> +struct tn40_txd_desc {
>> +	__le32 txd_val1;
>> +	__le16 mss;
>> +	__le16 length;
>> +	__le32 va_lo;
>> +	__le32 va_hi;
>> +	struct tn40_pbl pbl[]; /* Fragments */
>> +} __packed;
>> +
>> +struct tn40_txf_desc {
>> +	u32 status;
>> +	u32 va_lo; /* VAdr[31:0] */
>> +	u32 va_hi; /* VAdr[63:32] */
>> +	u32 pad;
>> +} __packed;
> 
> Can these be unaligned? There doesn't seem to be any holes in these
> struct, it's not necessary to pack them unless you want them to be
> unaligned.

Indeed, not necessary. Removed.

