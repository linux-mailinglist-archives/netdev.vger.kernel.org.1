Return-Path: <netdev+bounces-109427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BA89286EC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEDA1C21A95
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF41474B8;
	Fri,  5 Jul 2024 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkauFbEw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D514659D
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176014; cv=none; b=l4ZcaMuW3W94S536cmyNcWcZkzl6gKvtw58VcixgT8mv2PwmdVdffgOVYwWpoNrUuGiIRzrln6qjP9CzTa0tp0eYKng4TAY4YO3WGeEPBpWegv9AJt4gMlr5Sl/UIUCNQcLP3uHxM8UPspHQ0fG7++9RuB0Mgwh9VfHZwVyVmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176014; c=relaxed/simple;
	bh=ZGvT1xDmJslahOSBqA03ZitTdvlSMIv/MbUt+7QlP1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjI84DII3VPBjaKY1x+2jl+FZhdjpDn8K/onCmG4v2OnwUI6UWBSLPqz+jqfAT3jrhJrjoWeXpoIJn4D6V1UTdnGrBIFu8OAaPIPZ7K0p3k/wC1yTe9548+S4hwJ8yv5+C8bZVCuAkxlzmFHNw4cFvR88wnQmR2tfETeWF4gZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkauFbEw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee794ec046so16255371fa.2
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176011; x=1720780811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D5lcfiWWvRFNljf6NbtD3fhtcwluL6aZI4UzLgC3EWg=;
        b=FkauFbEwrRGqqRL0JrLoDTl+B7B91ZG3x1NfvDyvDGf9aD0qUIc1RDQUp1YlKJlNvd
         eGOCQjfAWG9ExMjMwpMkQwdWWsMOkm1OanIJbcqAJFwLUjJcyQbrAMuygdksn9giildt
         qMHa0v8VpEZQnsb1AISDZ7wkCxgonOcuEAAvBNGBHTQzguE9rf5LwnyFrNrX0t8rYAKj
         kOlusu3dXg1ByeSruzqjrSPXOMlSYufstdfC/PIgl9jaW5VNA/k+fd+T+v9gtcj2AyBU
         vpXSnTuowtnemhylAj3gdHfYDAcHeH8toMoSSImbKWjSiZrgj1amhcA3oIXltHpkMGhp
         Ym3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176011; x=1720780811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5lcfiWWvRFNljf6NbtD3fhtcwluL6aZI4UzLgC3EWg=;
        b=F4dod09zY0tDOnMrIj+I4ZGJGyAjWVu1YzxrqlUsj4jTGZ4i1eMmAzJ2cyQnDilOdd
         Inl4aHb4egcuYvGz4QENIrhSRy8+odT51VlXjxebIhRrX2Y36GQ5x42HjLIbemtEghR4
         nxvAb5FAoOsEvOuPk5J5I5WTbm1OJGkozpnpqSzkmxvu6LzpFSodLypRZhZZ1EVvB+uk
         GEBaj6/7EzDbjSUUgUjl84sHaoJpN692hM0QGlwgxX0YGI5dmFFOmFjuFhok02FMHpr8
         2IdpvG0BB1ggXWKxhHb3S7Nkk2CtB05iM5rEGutn4Lh7bXxQIWOLd2FdHZPXflmlte6O
         xNPw==
X-Forwarded-Encrypted: i=1; AJvYcCUMaETcn7aLJJD40DE1oM8BU96I400N9ZI/OaKGFyAQVUK/FDUpTzdPVPkNS141nBKZMQHLtp9r96O6Xj0wqj4zoXsmFVH4
X-Gm-Message-State: AOJu0Yzwbib+ilhGoCh80oSayfJki2m3azZJl8BYshvSgcEqoq/Df/BO
	463DRFIPTiwG8Y8PN9nySWdgqrWjFdcgXiVDqjh6bnOjEVs+4dXX
X-Google-Smtp-Source: AGHT+IGjpnsGTxEEZMUB39XVHRk7psPnU3AHL7SpJgx9SQOtCeeOoaWJdzlQMZALKnzaehYAsc22uA==
X-Received: by 2002:a2e:914c:0:b0:2eb:e365:f191 with SMTP id 38308e7fff4ca-2ee8ed8b895mr28137771fa.15.1720176011263;
        Fri, 05 Jul 2024 03:40:11 -0700 (PDT)
Received: from mobilestation ([81.9.126.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5a11d48asm22364681fa.100.2024.07.05.03.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:40:10 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:40:08 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, linux@armlinux.org.uk, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 14/15] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
Message-ID: <yz2pb6h7dkbz3egpilkadcmqfnejtpphtlgypc2ppwhzhv23vv@d3ipubmg36xt>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <16ec5a0665bcce96757be140019d81b0fe5f6303.1716973237.git.siyanteng@loongson.cn>
 <ktvlui43g6q7ju3tmga7ut3rg2hkhnbxwfbjzr46jx4kjbubwk@l4gqqvhih5ug>
 <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4JEec7CuNDaQX3AUT=9itcTRgRtWa61XACrYEvvLfd8g@mail.gmail.com>

Hi Huacai

On Wed, Jul 03, 2024 at 09:19:59AM +0800, Huacai Chen wrote:
> On Tue, Jul 2, 2024 at 9:43 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > ...
> > On Wed, May 29, 2024 at 06:21:09PM +0800, Yanteng Si wrote:
> > > ...
> > ...
> > > +#define DWMAC_CORE_LS2K2000          0x10    /* Loongson custom IP */
> >
> > Note it's perfectly fine to have a device named after the SoC it's
> > equipped to. For example see the compatible strings defined for the
> > vendor-specific versions of the DW *MAC IP-cores:
> > Documentation/devicetree/bindings/net/snps,dwmac.yaml
> >
> > But if you aren't comfortable with such naming we can change the
> > macro to something like:
> > #define DWMAC_CORE_LOONGSON_MULTI_CH    0x10
> Maybe DWMAC_CORE_LOONGSON_MULTICHAN or DWMAC_CORE_LOONGSON_MULTI_CHAN
> is a little better?
> 

Well, I don't have a strong opinion about that in this case.
Personally I prefer to have the shortest and still readable version.
It decreases the probability of the lines splitting in case of the
long-line statements or highly indented code. From that perspective
something like DWMAC_CORE_LS_MULTI_CH would be even better. But seeing
the driver currently don't have such cases, we can use any of those
name. But it's better to be of such length so the code lines the name
is utilized in wouldn't exceed +80 chars.

-Serge(y)

