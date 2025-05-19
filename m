Return-Path: <netdev+bounces-191379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943DEABB4DC
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F673B871C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E9422686F;
	Mon, 19 May 2025 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFJV9dLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF522538F;
	Mon, 19 May 2025 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634990; cv=none; b=d26xoIgVIWezQb6Eobd2icRF+cgkcX0EN0REHO4jBhc9l/erWSpR7+vBA14yrmDyO+eLUfnqsMIhr6h1Q/q5cLQtCIp7s3GLvNZvAkTDkYY0lcp48AUSQRR7t4Vmk99JSJE884DaQw1yV8RxQdSe1Ras/YKGelAWyfgasAJRwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634990; c=relaxed/simple;
	bh=96AL4BcJrGHqEJ9hFry1I6kX260b5WUQ2aCpMvWixBc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P8zSyc1QOs38aUla9TLBQXU+TlYYWaLHDYsLG87ZGF86DlDQ+hJrbT0RQRecb0jsSU1RUDm7e15JO36a9Nf6AvQ96L7fmUCrqBnH0ZpqjtAkbF0I+FzpsIgwBi5m1ylHQuT5ZfuVFDpQDt2dHu4uZmj4FkugTqK9rKE1xnj/xDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFJV9dLz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so3734887a12.2;
        Sun, 18 May 2025 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747634988; x=1748239788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZq5C2nAtqXvToxkhK76speunl4djNnbXazWf3GNPfQ=;
        b=UFJV9dLzEuOl8LthHnxdcKbTjU1Ef/xZyfvW76aqepCisXtGEOUkKCO7Sa2ZZdCBql
         9Dme/lYfZYX75khuf5DQww3VWWA/sjBaRUQtY735fo7X83eeiLZy7okiIRG/yB5HhPER
         UtDI7FIsIgTtVHoJNdOQR2FsuG7KiO6cwgD8a5GkR3bFPftBY95r9NFlVSQQX9OR6Y9U
         Xc/iYjVUrNq3iiqXecbP9Zo3nTg1vLhWFXHY/sJzr07QYcoB56bBZma6aeU5N0ZpVURv
         8tomN82QaqOecl+xBIHK0wHhfjPN4VBK2YBuwyP3h4iSSETC56XUSnO45culDCvvrY2N
         7q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747634988; x=1748239788;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZq5C2nAtqXvToxkhK76speunl4djNnbXazWf3GNPfQ=;
        b=O5I97UGyqm8865pwqSkz/7z0/JrWFCFh5W2mJ9Nq+n0/+MKR/czA3y8GAkHFb28Txf
         NotOjQTNCPBjvG5W4R3Fz7jw9E4mWA3kctbsEAH+6CQOhFf0rfJ1ZJbqk+IbESRP1LeI
         OD+80mg/vuRz+WWRy/ooUKN0ptNSsopD7F1upVP9hiEbdORJnrsOudCWNpRObN2sPD1U
         YwkrnJImsXgo1Qau9zPhfczFE274g33NBso/OZtPt2Wv1AD6hBi9q6lm8v/xYM3Pe695
         3ev0OWqjCsxvWEps45Ikud0DHTqNxiU969FtStGeJnwAc6HbS941YLAFQaiK29FsNXHr
         KOYg==
X-Forwarded-Encrypted: i=1; AJvYcCUVdmZUBqDJFdnFG/4FqLa4SsVlHsAi84TkhIPssZIBaMuM4jnsoWa/gheMRScXyqYI5Mkf4uB9l3BoFnl/@vger.kernel.org, AJvYcCV8UZ4GBPn12XT1rGglR1PaJlK1+sUhtx22utOUaXZm3yNtAVwOk03rR9hWJk3cbTebL+V7St0gZQLm@vger.kernel.org, AJvYcCWav5Sya0xPwy2tmjHfonat4Gk4j52mUi5J0f5EQjLXxiJABatSBJWrFcVpcgSGfcm/T4Iz2OlR@vger.kernel.org, AJvYcCWewnR2LTpFGU8EEAuy6TgqJyiv2kZaTLE/ziaFfjfvjAsubbVJoNNq7zTii8X21NV5Fz/7S6SBo9TeBFq2UCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw56Ma1GjXA7w9+7JD2o1NkM0AZ0UmS+8aRLbRrCi64Oly0sxs1
	X8FnwQYaA2JtfbmugxsHF5+YOlFsD88Vvi100GCpBBfspLfpx76jmuz2
X-Gm-Gg: ASbGncsCyXD3OinWBe8nnPfsVBN3nxXByOgqz07QG3ST8m0pQwP+EVuK/W0SVWuogyX
	oEzYjrvxQk6p9GaJCQJmeUU546rRB22w1sIBdAIuEHP1GBFj20mcAJsIOT2xqvgmde7vFlqi4dx
	Rr26PZpuiuFtVTEDwbJvigvfYfyOch234kM+TyNAGujnbCLPpmcwbP8Qlai70Jv9DF7f/+gvnDo
	ZriSVxxZ2h2SIBkNf7T2qu3o6ygDrHKSrIObfM5QOaLP38rJumC6WcqX6T7GadfmdQrFTx2VipW
	z+1DLkTuAXd0I67da5pcDNZ5rKgTAsYRoiPuvAnQmZLOqUhcanum9ZOnmn9ffHs6TSl/8hj7OOs
	Vasm75oeKBsrJ3SzkOW0Jwy/4DeqHAKlSVw==
X-Google-Smtp-Source: AGHT+IELag7CjPk/EztKgu/bui7qkSTouCTFpuh6lXhH2TBCVewVe8EY8r5ytRPlESvuwqMCXQHS9w==
X-Received: by 2002:a17:902:c949:b0:220:f449:7419 with SMTP id d9443c01a7336-231d438b3femr160373195ad.7.1747634987701;
        Sun, 18 May 2025 23:09:47 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba524sm52135435ad.191.2025.05.18.23.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 23:09:47 -0700 (PDT)
Date: Mon, 19 May 2025 15:09:29 +0900 (JST)
Message-Id: <20250519.150929.1041324722416773408.fujita.tomonori@gmail.com>
To: ansuelsmth@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 kabel@kernel.org, andrei.botila@oss.nxp.com, fujita.tomonori@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, sd@queasysnail.net, michael@fossekall.de,
 daniel@makrotopia.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 rmk+kernel@armlinux.org.uk
Subject: Re: [net-next PATCH v12 1/6] net: phy: pass PHY driver to
 .match_phy_device OP
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250517201353.5137-2-ansuelsmth@gmail.com>
References: <20250517201353.5137-1-ansuelsmth@gmail.com>
	<20250517201353.5137-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 17 May 2025 22:13:45 +0200
Christian Marangi <ansuelsmth@gmail.com> wrote:

> Pass PHY driver pointer to .match_phy_device OP in addition to phydev.
> Having access to the PHY driver struct might be useful to check the
> PHY ID of the driver is being matched for in case the PHY ID scanned in
> the phydev is not consistent.
> 
> A scenario for this is a PHY that change PHY ID after a firmware is
> loaded, in such case, the PHY ID stored in PHY device struct is not
> valid anymore and PHY will manually scan the ID in the match_phy_device
> function.
> 
> Having the PHY driver info is also useful for those PHY driver that
> implement multiple simple .match_phy_device OP to match specific MMD PHY
> ID. With this extra info if the parsing logic is the same, the matching
> function can be generalized by using the phy_id in the PHY driver
> instead of hardcoding.
> 
> Rust wrapper callback is updated to align to the new match_phy_device
> arguments.
> 
> Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/bcm87xx.c              |  6 ++++--
>  drivers/net/phy/icplus.c               |  6 ++++--
>  drivers/net/phy/marvell10g.c           | 12 ++++++++----
>  drivers/net/phy/micrel.c               |  6 ++++--
>  drivers/net/phy/nxp-c45-tja11xx.c      | 12 ++++++++----
>  drivers/net/phy/nxp-tja11xx.c          |  6 ++++--
>  drivers/net/phy/phy_device.c           |  2 +-
>  drivers/net/phy/realtek/realtek_main.c | 27 +++++++++++++++++---------
>  drivers/net/phy/teranetics.c           |  3 ++-
>  include/linux/phy.h                    |  3 ++-
>  rust/kernel/net/phy.rs                 |  1 +
>  11 files changed, 56 insertions(+), 28 deletions(-)

As for Rust PHY abstractions:

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

