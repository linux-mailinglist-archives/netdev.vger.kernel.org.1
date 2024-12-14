Return-Path: <netdev+bounces-151957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8CB9F1F95
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 16:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9A1886289
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C419580F;
	Sat, 14 Dec 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBn5msUl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DE1E502;
	Sat, 14 Dec 2024 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189125; cv=none; b=Q5YxKJeyrJc1VRs+HaRZqiIq4zo2VVCF03mc8qT1ZsFeOeqlzXPfk6QjuNG56TPRFq3nwcfTZYlU1d3YcSlhvmUDI0BUwjvchXffAuDLm5BNoSLUSQ1uN2+2XW4c3mh2CvGBPg2rJPLgI64+muC0ytb4VamP56KueRz7f1HQNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189125; c=relaxed/simple;
	bh=OV2E90rAwYOhQnvtMiuQ1tWY/nSbw11TrYTbYk+0hFY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNEMmYL89laxVyVbcuvV9X2UDWQqU/whmez6M790UpnldjsDEf4mbwTr8Nvv66zok5DBw8a+lqjLvPlUQHzu0zmFaE/bWbFhv/i4aX3l3EydQXt/OjLf0vhcLmi9wDrsUS1lUfCn5cDcviT7VeLTcOgGdKy8+nqMrp95ag46t/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBn5msUl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso28060865e9.2;
        Sat, 14 Dec 2024 07:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734189122; x=1734793922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kSxXgL0V1UHwaghXfPnwj6ZyebGhbcff5eVA8hQElAg=;
        b=IBn5msUl/hdN0EZln3Q8h91N09zMNVA98sEW2tucR+JYfCfHbI0nvSe+AWtijq+m2y
         Ppw3fcKFSimlepxJddxJJ3P6RnTzqTSoIBJg1frmAYLGDeXWxbDQSBdGdaTydb/m2cxl
         THOrL7dzDYTy5cN6y7iZXRzpW5F2HNGEeKQ/i3CejL3Ml2o9GPT3vG6ASvDlOV2hhd11
         CNoL8dwoiR6nWEd1uJuKjjVsNe/++YucswoZNj7UQT48w6NSHRZr9A1Otzulr2oFWDsp
         DJyBfuSzyEnJZgXOnXuGY4xaWgL8rH/Fa88CrY0dgVJVufEXQ9GgwhdBNv4OEP+bJtyE
         qGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734189122; x=1734793922;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSxXgL0V1UHwaghXfPnwj6ZyebGhbcff5eVA8hQElAg=;
        b=VKcPvY7h6UoOMVT8zUItiqbtZPJe2D5XZ99YOwYtbSIQ1LArdhZapGLfTsonpwBcSd
         78ClRQLkvEujWaxqW6PT3DSKa/KKmzL0UPU/KkxxMXxRjVjgsO+ECsOU+d/ZoKUDaKXv
         DE4uD/kJ2Wx6dKgCQXUquE0FTvfiDxVqzjH1k7//Ut9y+xFh0ok3DU3jRure8k0Ntrh+
         M6598mU0zTlvX+VGFhtkx3lsg6DgyqxpiqLKE39U1QKea2WSG+x5R2CUnjYLizQco40R
         1wEf3lcufTQnIKRTr4oAzYw6AMmkfKytJfE+VCDRIx1rcqtLve0Kw1PyUs8BH5pNMHcC
         dGQA==
X-Forwarded-Encrypted: i=1; AJvYcCX+/ck95mnvkmIhAAo0xQfPI38guiIE71+2Axdpd9iSAnYLxJbqLAFKknBgrDPzPS+x/99zN9uYHtoF@vger.kernel.org, AJvYcCXNrFwWr6F6RA/JhemOrf6N4o+WMglye4qamlkNCornH+4/3WimFxdMHOCpAgxdnXM8roCDb/vR@vger.kernel.org, AJvYcCXkbirf5tJ5Kbez3MzHFdjEGIC7/tVGwD7rwiqfT5k1Zxa+cmla/aXaOir/Kk75bA9A1gi2mnY/81J/NY7B@vger.kernel.org
X-Gm-Message-State: AOJu0YwDsLS6z4Y14S2heACxglzmTur+8mRth6cL9WRHAtKB0Cv8UtLx
	0CseNnDSD3K8teYLDjihfcvpimPaUw7nzh9Qjqj5PrBFjLH6Hal6
X-Gm-Gg: ASbGncshUmY/OcmvDoysA+GAowW+GOSiVT+eHjPEHU11drylgct5+2GcK/sxx0vqjzf
	XGBZmgMZ1c9zQLN3Sx++LhaeSPyWsNeUwS5ZUCyFNKGMUWotDRAWnxlGJBf6Et6onw6QPGv5pq9
	6yr3iVecSUdaU/HW2li+Amvez3OJrhrYw9mSCsU+n1xJdBFflvWq9Ee4B0CVNqygy6fGCHeaU+N
	r0S0qtXog0isnKg4etAzuPHDd9foiD8Z+ndHpMDM9V5t0VBQpZoz0ep3fDlLrLvMBN8OfG1J5/V
	pLcnC5yp7RgP
X-Google-Smtp-Source: AGHT+IHviim7NbVtUOIT+HnieV8oHcaBrBqk3Euy0/kRPqRbIEFM5mW2+1jwbLENz44EIQcBecLugg==
X-Received: by 2002:a05:6000:2a3:b0:385:e4a7:df07 with SMTP id ffacd0b85a97d-3888e0b9ea9mr4497177f8f.42.1734189122114;
        Sat, 14 Dec 2024 07:12:02 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362571776asm80794525e9.40.2024.12.14.07.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 07:12:01 -0800 (PST)
Message-ID: <675da041.050a0220.a8e65.af0e@mx.google.com>
X-Google-Original-Message-ID: <Z12gOtM4EWWMgLnI@Ansuel-XPS.>
Date: Sat, 14 Dec 2024 16:11:54 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241210211529.osgzd54flq646bcr@skbuf>
 <6758c174.050a0220.52a35.06bc@mx.google.com>
 <20241210234803.pzm7fxrve4dastth@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210234803.pzm7fxrve4dastth@skbuf>

On Wed, Dec 11, 2024 at 01:48:03AM +0200, Vladimir Oltean wrote:
> On Tue, Dec 10, 2024 at 11:32:17PM +0100, Christian Marangi wrote:
> > Doesn't regmap add lots of overhead tho? Maybe I should really change
> > the switch regmap to apply a save/restore logic?
> > 
> > With an implementation like that current_page is not needed anymore.
> > And I feel additional read/write are ok for switch OP.
> > 
> > On mdio I can use the parent-mdio-bus property to get the bus directly
> > without using MFD priv.
> > 
> > What do you think?
> 
> If performance is a relevant factor at all, it will be hard to measure it, other
> than with synthetic tests (various mixes of switch and PHY register access).
> Though since you mention it, it would be interesting to see a comparison of the
> 3 arbitration methods. This could probably be all done from the an8855_mfd_probe()
> calling context: read a switch register and a PHY register 100K times and see how
> long it took, then read 2 switch registers and a PHY register 100K times, then
> 3 switch registers.... At some point, we should start seeing the penalty of the
> page restoration in Andrew's proposal, because that will be done after each switch
> register read. Just curious to put it into perspective and see how soon it starts
> to make a difference. And this test will also answer the regmap overhead issue.

Ok sorry for the delay as I had to tackle an annoying crypto driver...

I was also curious about this and I hope I tested this correctly...

The testing code is this. Following Vladimir testing and simple time
comparision before and after. I used 100 times as 100k was very big.
From the results we can derive our conclusions.

static void test(struct an8855_mfd_priv *priv, struct regmap *regmap, struct regmap *regmap_phy)
{
	ktime_t start_time, end_time;
	// struct mii_bus *bus = priv->bus;
    	s64 elapsed_ns;
	u32 val;
	int times = 1;
	int i, j;

	start_time = ktime_get();
	for (i = 0; i < 100; i++) {
		for (j = 0; j < times; j++) {
			regmap_read(regmap, 0x10005000, &val);
		}
		// mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
		// // an8855_mii_set_page(priv, priv->switch_addr, 0);
		// __mdiobus_read(bus, priv->switch_addr, 0x1);
		// mutex_unlock(&bus->mdio_lock);
		regmap_read(regmap_phy,
			   FIELD_PREP(GENMASK(20, 16), priv->switch_addr) |
			   FIELD_PREP(GENMASK(15, 0), 0x1),
			   &val);
		times++;
	}

	end_time = ktime_get();

	elapsed_ns = ktime_to_ns(ktime_sub(end_time, start_time));

	pr_info("Time spent in the code block: %lld ns\n", elapsed_ns);
}

With the code changed accordingly.

switch regmap + page (proposed implementation)
Time spent in the code block:  866179846 ns

switch regmap + phy regmap (proposed implementation + PHY regmap)
Time spent in the code block:  861326846 ns

switch regmap restore (switch regmap read/set/restore page)
Time spent in the code block: 1151011308 ns

switch regmap restore + phy regmap (switch regmap read/set/restore pgae
+ PHY regmap)
Time spent in the code block: 1147400462 ns

We can see that:
- as suggested regmap doesn't cause any performance penality. It does
  even produce better result.
- the read/set/restore implementation gives worse performance.

So I guess I will follow the path of regmap + cache page. What do you
think?

-- 
	Ansuel

