Return-Path: <netdev+bounces-102162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D7901B62
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F410F1C20AD4
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D314277;
	Mon, 10 Jun 2024 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRa3YWcr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D1EAC0
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002146; cv=none; b=P3MJ+hlOg9gGwBRuhBh8Lub8XQpZxG4O7hYZFSiBJLWu+cf7qsIrSaT/6yjWcoj41Cq37QvBSfgbAMRIIV6kbLL5s0yb8Q/4sqmcOd3+YEUffGLlXkrf/dHCDoY02bSOVVF0EzA1rAezmDRxdETzONdPKNAQQ603fAZ3NIFZzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002146; c=relaxed/simple;
	bh=RxtFhDv7aazWQS/C2IL6CCUhG+lo0KNOcMWTNpr9UGc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I+YBN8R1ls8BVwS0RQLGXNtfvDCbCWk7aB7Afm2FKgR1AunFdM9S6lzY84WFdWsKdxwl+eYLstwePmmXuGh1G4lH3z1VyEyrdUbBHzwcmDG07uKGn3J/RY47/Q2nGFSjE4FYo9s4YITPs1tCEhf9SAEKx0kC6zFlw1toqrWJfr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRa3YWcr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6dccc583e89so383621a12.1
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718002145; x=1718606945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tiFCxbQmubccYDKzcVOwGtlOUgG6kDA7PwWy7xXhMzo=;
        b=WRa3YWcr5lUOfou8VyLv/cdZGdGxIxhk0ynZgP2o6eyX/7ns/pGz7rzQQ1gEYatqfK
         Sa2eqV2eWvULFbHRk9fErT3GKI05o6VEzGeoEioFS1DrQNPpa7Kq1QZVtyqSXuxjWRUO
         C73F3QsOBDdXDeuUkCZq9d/8yq9Ug/G26IOExLdTgTv20dDQU6yLxjVtG5cOGjqdzrmG
         XT2BAOvrVlkzwbVXLz/xGcXP0JTyKrDP+7icoV4SXnjiTaewUwre3f6gdNDXrRRqwdUr
         3UT3U4RmiCQ+bs1Srkeb92pIDF2L8CGkNDMexDdWR/bUpgkQK/oYDjKbR3cUUP5c4JT0
         uZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718002145; x=1718606945;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tiFCxbQmubccYDKzcVOwGtlOUgG6kDA7PwWy7xXhMzo=;
        b=R2DfoR08RfCQeysZA8r/DgiAKCKvixyN1ZJPkLnm2IHpFhwahQHLnBL5uRP9pXTrJR
         91EnTzMyxo9GCatqh+TfV6uw6sdPJbwhKu53tot5+YyCaHLRrZcucJVmuoeMvjcGohUk
         wJG9CxU+lNEhHnz5lz9tgnqVU20l2MRo26PaKM9/ClPey5Uh60YrAK7kfyvBw/bMuFgn
         1Qm+H3WnsTITAuDdbNN9suBX3DMQsm0fQ7Vexi21qdlqSl8EfxOut1NF5eCFy3nSjjCI
         Op7o3BTr0CxVdPBG3CZMvU8BLDxxOYmWRE9LlhIwyvkwr8+RLEwQJVbk7fXf+G+wvZEa
         7oAw==
X-Forwarded-Encrypted: i=1; AJvYcCVF/QedsKEjDrY/JQzo0tA4QHzTxOlyWXgIgfPb8jwLtSbn5/MERuTk7VBDya3jP7CLlH80fJI6eVfW85xL3tzpcpEf3s/n
X-Gm-Message-State: AOJu0YyI5Z8vdYmnRtviOL313pgHdYXodImMb6NTTUJcruB9RNv3Dx0K
	l4QYKVhE8ldvi6K5CiwJ2J5lU6KGrfWAwdtvzDi46rYVbFQh08ak
X-Google-Smtp-Source: AGHT+IGDpHRH0hsc9s3acoPsx99Zr72p2h+4R89+XviAwJKrqmK282aI/hNccPWHYIPba+SW30ezTg==
X-Received: by 2002:a05:6a20:9498:b0:1b5:ae2c:c730 with SMTP id adf61e73a8af0-1b5ae2cc825mr4118456637.3.1718002144691;
        Sun, 09 Jun 2024 23:49:04 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f711sm75305975ad.11.2024.06.09.23.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 23:49:04 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:48:50 +0900 (JST)
Message-Id: <20240610.154850.1916370094900982618.fujita.tomonori@gmail.com>
To: hfdevel@gmx.net
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch, horms@kernel.org,
 kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/6] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <78ecc7a9-bb33-4c2d-a797-87f782b6a382@gmx.net>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
	<20240605232608.65471-4-fujita.tomonori@gmail.com>
	<78ecc7a9-bb33-4c2d-a797-87f782b6a382@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 9 Jun 2024 13:41:20 +0200
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

>> +static int tn40_priv_init(struct tn40_priv *priv)
>> +{
>> +	int ret;
>> +
>> +	tn40_set_link_speed(priv, 0);
>> +
>> +	ret = tn40_hw_reset(priv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Set GPIO[9:0] to output 0 */
>> + tn40_write_reg(priv, 0x51E0, 0x30010006); /* GPIO_OE_ WR CMD */
>> +	tn40_write_reg(priv, 0x51F0, 0x0);	/* GPIO_OE_ DATA */
>> +	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, 0x3ec8);
> 
> the last tn40_write_reg (to TN40_REG_MDIO_CMD_STAT) is in fact the
> same as:
> 
> tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_1MHZ);

This means that as the original driver does, this driver sets bus
speed to 6MHZ for QT2025 PHY, however after that, this driver sets
it to 1MHZ again?

