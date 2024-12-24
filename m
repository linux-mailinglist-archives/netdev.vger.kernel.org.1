Return-Path: <netdev+bounces-154145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B79FBA1B
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 08:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D86C1884713
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D814E2C2;
	Tue, 24 Dec 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tITeap0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC23EA69
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735024521; cv=none; b=gtZvarsY4Mh01Y+Pi6HPxNxZ/cVZ/cRRMojHxTggpjiSKmGR5qELCeeYhNkNKkUwlf1pXFlxvIFDx6GcYzjOC2zokfvtnIPCxtreIYKDEpcH8KD8RqMw9/WoQApIN6mDlHSdHaYrdSPChBjtt9ANGbE0Dfyo9F/2P/3PIVK73ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735024521; c=relaxed/simple;
	bh=YHJSI4t/qgGEI2FEsSHGesZLQnLP+7ZOWpEdS9vfwdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXcsG+6eVEI4cKOQjNZA+xSW6JDh4T/RUNV1kcLxyZWcSw4Ytc1P8gozonz2VxY8c4RBVoVSOXgh9E5gBS1XJTztLsW6rD0pgjeazr6yfRRb+VN1ar0lXkYBByL0SDKlqwtC8u3ppEOZ1y5UB/qMzJcxfP9vUM1mYUy2XTzeD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tITeap0A; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so5079070e87.3
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 23:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735024518; x=1735629318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWUlsCwdGlYVoLTTlNmK9JqyX+ELLJR/XrPbGHFiz4o=;
        b=tITeap0ANTmSnrBxgskwGtsZYTnzP4g3R+f0MD+PSSDYR5a9HBvNLHJ3RqhohaAiUF
         1p2mQdVqcKD+Eqhx98Cq9FY8gwY1q2G9d8cbH/sLRCs9MA8jdWpcSrsyYEU/pPDJi5ZN
         1Wc9xE0/vI9Jm3w/lfNWls9yrx99bzbNsB0aEFdmA5ISZhWnF7uQHgFgVQXzhg9qlQmy
         9AlVDjihFS2JAfprjmGKMekpthO744FKfZPrYqNMmhGeB51gXisSU18S0DpjLyqKbngZ
         D3+dvSIzAPj/X+tXgKN0Q4H63+2ZNN7PFdxEeZdcyc5bNnUwP9eE7cLJV+iFrRoxTjwe
         Q2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735024518; x=1735629318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWUlsCwdGlYVoLTTlNmK9JqyX+ELLJR/XrPbGHFiz4o=;
        b=i9S2rdmVNTU9X4+PhedcYA48TGs0YDnmelQZUa9RvUV9FvdmVUhUUTrVZlKqPdu6My
         uoLbrmCfsw1OcAASRGAUQQ4gx3sEC4589dzxzc1fFg7YTiU1fzJJ7Sf7g8q3/Lg5Eoeg
         47Mg7MBnBxvR7zu/OQZvC7S4Fv67nCHBJ5eYcoDlmkjqMULMF34RdzDhB/9fU35qXrmB
         fad9rUOAF4zm0Emqha19D31Pcm11FtmglhY84N4s8Mh/nWNrz8Dy5kcm1LY+LL0fidUY
         oqcXXmaYwQFyPgCB794gGdTjRtAretj60milfuiS+vaUDvmHubMcdA/XbgJTuOnHW2Xg
         Zg2g==
X-Forwarded-Encrypted: i=1; AJvYcCWGnu2qQP2VYBx+u0OBdR0kGdUF6fEcIS6mKdeVsWVr1hMqEDhp95rh1bZzAA01H6XDUClugng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsn6lLDeB5F4VOAjXCpkkYBKmqee5LBWFCF25gwMW7HLyzNoie
	Ij/XlSGpWMF0iVHqPw7Qoyfsdi1isWllZP8f/L/gWHDQxCZ4YWXZaAwCcUzADeg=
X-Gm-Gg: ASbGncuZ2uch+5Z5phQV1IpqyQD8DYUPUh30hs/0zIt4OVimcNM22Bx9Tg0CalUh0kt
	nUkgvKeYMrk1sKbvNJ/WU14cdoZswFZoQSVIbnJSfpOFqdn5Tv1KaxIfGaANUVvsqWVtxQKXJu2
	5/B3KDcynDOqELmvWXBULpbV/d3YveLAON4GbJUwwvA1+LHRHd/7dtlEYHXMlCRgLOrWZ7B8bcB
	daScKnAXAYeyezsy6jspaWtLRJkKbQvj4lCf1uNp10qBGwhs3KCHEDZHib5DyNcaTpH4bysds+l
	8BtNk/nceJtndOPftIF3LAQFtdpkj4kegAa6
X-Google-Smtp-Source: AGHT+IEKTeNBvQTu9YRBoejIqf1EgZ3qzhUiijhRn6wPkG9McwpCWPDfTiwpc8nJ3zhgXTioKcIefA==
X-Received: by 2002:a05:6512:3e2a:b0:540:2311:28c5 with SMTP id 2adb3069b0e04-5422956c4c7mr4452369e87.57.1735024517908;
        Mon, 23 Dec 2024 23:15:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238138c3sm1507194e87.140.2024.12.23.23.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 23:15:16 -0800 (PST)
Date: Tue, 24 Dec 2024 09:15:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: Lei Wei <quic_leiwei@quicinc.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com, quic_pavir@quicinc.com, 
	quic_linchen@quicinc.com, quic_luoj@quicinc.com, srinivas.kandagatla@linaro.org, 
	bartosz.golaszewski@linaro.org, vsmuthu@qti.qualcomm.com, john@phrozen.org
Subject: Re: [PATCH net-next v3 3/5] net: pcs: qcom-ipq9574: Add PCS
 instantiation and phylink operations
Message-ID: <yfh7kghxy5hjblnzlapcpzj54chep45pjkgpvelzbp4ijuq7ci@e6te6c36mkxc>
References: <20241216-ipq_pcs_6-13_rc1-v3-0-3abefda0fc48@quicinc.com>
 <20241216-ipq_pcs_6-13_rc1-v3-3-3abefda0fc48@quicinc.com>
 <d278ad9a-5d23-4cb8-9de7-5a51d838ba5d@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d278ad9a-5d23-4cb8-9de7-5a51d838ba5d@quicinc.com>

On Tue, Dec 24, 2024 at 12:29:56PM +0530, Manikanta Mylavarapu wrote:
> 
> 
> On 12/16/2024 7:10 PM, Lei Wei wrote:
> > This patch adds the following PCS functionality for the PCS driver
> > for IPQ9574 SoC:
> > 
> > a.) Parses PCS MII DT nodes and instantiate each MII PCS instance.
> > b.) Exports PCS instance get and put APIs. The network driver calls
> > the PCS get API to get and associate the PCS instance with the port
> > MAC.
> > c.) PCS phylink operations for SGMII/QSGMII interface modes.
> > 
> > Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
> > ---
> >  drivers/net/pcs/pcs-qcom-ipq9574.c   | 463 +++++++++++++++++++++++++++++++++++
> >  include/linux/pcs/pcs-qcom-ipq9574.h |  16 ++
> >  2 files changed, 479 insertions(+)
> > 

> > +
> > +/* Parse the PCS MII DT nodes which are child nodes of the PCS node,
> > + * and instantiate each MII PCS instance.
> > + */
> > +static int ipq_pcs_create_miis(struct ipq_pcs *qpcs)
> > +{
> > +	struct device *dev = qpcs->dev;
> > +	struct ipq_pcs_mii *qpcs_mii;
> > +	struct device_node *mii_np;
> > +	u32 index;
> > +	int ret;
> > +
> > +	for_each_available_child_of_node(dev->of_node, mii_np) {
> > +		ret = of_property_read_u32(mii_np, "reg", &index);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to read MII index\n");
> > +			of_node_put(mii_np);
> 
> Assume, the second child node failed here.
> Returning without calling the first child node of_node_put().
> 
> Please clear the previous child nodes resources before return.

s/clear child nodes/put OF nodes/

Note, for_each_available_child_of_node() handles refcounting for
the nodes that we looped through. So, I don't think the comment is
valid. If I missed something, please expand your comment.

P.S. Please also trim your messages. There is no need to resend the
whole patch if you are commenting a single function.

> 
> Thanks & Regards,
> Manikanta.
> 
> > +			return ret;
> > +		}
> > +

-- 
With best wishes
Dmitry

