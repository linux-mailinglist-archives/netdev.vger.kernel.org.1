Return-Path: <netdev+bounces-277322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAsYHRLP2GngiQgAu9opvQ
	(envelope-from <netdev+bounces-277322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2A3D5980
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E589E3004F47
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8323738228D;
	Fri, 10 Apr 2026 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUWc2OsU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7C37D13B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815989; cv=none; b=UKTKjV8DwC9wulGWx+6f2ILXSx/rnTQWJELH7LLcGHMsNV37+sXBs2SPEM/jSSl3EtP7cSDJ0IBC3SI0tXG5sXBdQYhV+6l2IEXZPqom1na6D1HTOGujtc7qiczQpZtfUlN0wbI+xR8whrH5k5w0GpyzU+cAWIoM89vFGDl6dwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815989; c=relaxed/simple;
	bh=s3HSXdKSyIkcESo540yOBfKDQGPWz6K+gdJhI4AKBAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cjcY54lYEPyJA+1Efc/Ez6bNSg6ESzPwdARZSt/nu8cJc6KiZLsqBY5mnbXWmopxiqkUWCm7gTa56vDA36KJlyo8nNuPvbm9AiK7oGg57bItmmSCIwwhkD2oDIlWqa+nXrf6lCdfPtYAswxaQXtdTYsWj/ybahGd4xk/0fAOvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUWc2OsU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so1122329f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815986; x=1776420786; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwB7g79B6BjA0+Xznt/2y7rPvZ8/aBLAkG1Izs3H814=;
        b=dUWc2OsU0L0Ft/GMC2pc0rGAxSwcmRAC4Vr2YQU7AQ4/YssT66FBYhoJPvPh8zzWQA
         ZahzgJANkpO/UBmF5dccsztqOFrm1MeiMAHFiRknKV1XvE3FuVPQ5wP/gHyVDF+l76LZ
         KhQnXr1eChbcMXNhKFM2Lrbm/7k5czxKFX2UNpwfYqSG+kLOdameUNqEIcyh/n3T5rSY
         xiebDcf2ZG3NoCpKQm9T6coE4KzX26FrNy4f7Azfutuk1ljqHCOZZ9XbOYBpBT16WI5a
         o2WXprHAMT4dwTCKxlAZcq5jTpVivqganljbIxAvEr+BL7J/cTj+M7TSgC0yJoV6pPl1
         nC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815986; x=1776420786;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwB7g79B6BjA0+Xznt/2y7rPvZ8/aBLAkG1Izs3H814=;
        b=e1YHmjBlZDcqHfWNIe/qYn4f+dbi1sEtVwAKUQo7Hju6zNvUaNNq1Rsq24lZeYbENO
         zn/0j7F9EosuSEyIJO3rb28K/R4CR9hr7gKVfUzKjmkagw5N8gYLZpTDTYkximJJ0cbI
         GRZzUpWSDuwqsj8cv50WfPX1+dB0/PF1MDH4SKVGyEeDd6FlMLO4lwkK5P39QpYzaXYs
         YzDP3zYg5c3Xa3dBsJMccydVLMy0caLmCRRpF6tjIwgef4GzzK5tFgVNDNqwW1iJzeDO
         noux1RmW+L5ECWmRuxXyvOoI1dhqgK9kcphOAOGwAxN3WLR8KAVOpKzPt46oSmDSqqP+
         hpzQ==
X-Gm-Message-State: AOJu0YxONXCyPEv2nL6A5h4T0QRdzPPMQHwWgMzx5QqAQK/MkDr5uTu6
	s7HYeKnVIuFUcnK3iyJxulF9OP8wlHju9sP0H+u2yb1DpG+nmVgmMFbG
X-Gm-Gg: AeBDiev0CVOtimDVNlGkG7I8k394rV1VFKeIFtmhcMkaLsxgoxhGyDNEONf52bJYpr5
	NWcyzk7UFIlQjdB8ioDGh4ZNUBbPA544CsaFLuoire1+FHHDZ8rCX1n9Uj26mbiOf1xM0cXflYE
	oOIClzGdLEAEqf/8H0b77o87eK3gu97AhNlYS3ilIbTWQtHX7qzC4I4OweUlAg3lomNFQH2bV2r
	yN+9b8HZWsDUueUwo4kXVKsK3kiteNnBpdN1BJ5H4kyOVqlnGQ0DJ9DmFhPvIzVBOCb01pAkng8
	i/guyWLpHIler4EChBCUjhpPuq2MEG8kXIxFzwQcDWRoM3rd37oxxZTi5d45zz1Kq/hJXP+mufF
	ErRm6c5wEup0yZ7YnOI85mooXwPDG6c583T3GC3iaRPZN+RjluCviDtEhMSxjiJiKfQrRk/+fNO
	OlR3fUhSm6YJgdaveH1P0=
X-Received: by 2002:a05:6000:15cb:b0:43c:f952:4292 with SMTP id ffacd0b85a97d-43d595d9fd5mr8222127f8f.27.1775815986403;
        Fri, 10 Apr 2026 03:13:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec07esm6599769f8f.13.2026.04.10.03.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:13:05 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:13:03 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Gospodarek <andy@greyhouse.net>
Cc: netdev@vger.kernel.org
Subject: [bug report] [NET]: Add Tehuti network driver.
Message-ID: <adjNL2q19v23xsAv@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0D2A3D5980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Andy Gospodarek,

Commit 1a348ccc1047 ("[NET]: Add Tehuti network driver.") from Sep
17, 2007 (linux-next), leads to the following Smatch static checker
warning:

	drivers/net/ethernet/tehuti/tehuti.c:2210 bdx_set_coalesce()
	warn: no lower bound on 'rx_max_coal' rl='s32min-15'

drivers/net/ethernet/tehuti/tehuti.c
    2179 static int bdx_set_coalesce(struct net_device *netdev,
    2180                             struct ethtool_coalesce *ecoal,
    2181                             struct kernel_ethtool_coalesce *kernel_coal,
    2182                             struct netlink_ext_ack *extack)
    2183 {
    2184         u32 rdintcm;
    2185         u32 tdintcm;
    2186         struct bdx_priv *priv = netdev_priv(netdev);
    2187         int rx_coal;
    2188         int tx_coal;
    2189         int rx_max_coal;
    2190         int tx_max_coal;
    2191 
    2192         /* Check for valid input */
    2193         rx_coal = ecoal->rx_coalesce_usecs / INT_COAL_MULT;
    2194         tx_coal = ecoal->tx_coalesce_usecs / INT_COAL_MULT;
    2195         rx_max_coal = ecoal->rx_max_coalesced_frames
    2196         tx_max_coal = ecoal->tx_max_coalesced_frames;
    2197 
    2198         /* Translate from packets to multiples of FIFO bytes */
    2199         rx_max_coal =
    2200             (((rx_max_coal * sizeof(struct rxf_desc)) + PCK_TH_MULT - 1)
    2201              / PCK_TH_MULT);
    2202         tx_max_coal =
    2203             (((tx_max_coal * BDX_TXF_DESC_SZ) + PCK_TH_MULT - 1)
    2204              / PCK_TH_MULT);
    2205 
    2206         if ((rx_coal > 0x7FFF) || (tx_coal > 0x7FFF) ||
    2207             (rx_max_coal > 0xF) || (tx_max_coal > 0xF))

Check rx_max_coal and tx_max_coal for negative values?

    2208                 return -EINVAL;
    2209 
--> 2210         rdintcm = INT_REG_VAL(rx_coal, GET_INT_COAL_RC(priv->rdintcm),
    2211                               GET_RXF_TH(priv->rdintcm), rx_max_coal);
                                                                  ^^^^^^^^^^^

    2212         tdintcm = INT_REG_VAL(tx_coal, GET_INT_COAL_RC(priv->tdintcm), 0,
    2213                               tx_max_coal);
    2214 
    2215         priv->rdintcm = rdintcm;
    2216         priv->tdintcm = tdintcm;
    2217 
    2218         WRITE_REG(priv, regRDINTCM0, rdintcm);
    2219         WRITE_REG(priv, regTDINTCM0, tdintcm);
    2220 
    2221         return 0;
    2222 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

