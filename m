Return-Path: <netdev+bounces-137792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ADA9A9D79
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6048928318F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FB1188704;
	Tue, 22 Oct 2024 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KA7dZCr/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9A1917C8
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587183; cv=none; b=BmZrOjBUdEt26emvnwz/IjAAgqKS4JtPCQJQg1GJWVOdL5gI+e+EgoQJmpgWY9ywuALg0/lWyKISKSfxrwlGXtJr2Glv3+yfPGSUWy3NKkTEdNEWoqsK9WGEthxJ1bS5b5moawdR0XvEiAd5i8R0JCnjwXmP2M9sYU5M8fFvHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587183; c=relaxed/simple;
	bh=854v+rtx3vuJ3B0OwYddESJ7z9HjkPSM3IByHYpBUW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a6ClxW22US9XJoTsSKhGRLlVhr/8twXMCVJ5B2yr5rTVTq2t5fya5sWPnIOq9xMAQQ5esmoiaGKABJwGwqbscgYlFNx0P/JiqQiHbGEdyyoknZmqdboQBeFbYmWleAlRjZp2xgMdmzK+JYPIusDMNtfxROuNyLoQV0pBBBTWBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KA7dZCr/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d461162b8so3586909f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 01:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729587180; x=1730191980; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehh67ak1ioateKr68RZqUNIbd4XGcxrlqGgTaUiYc1U=;
        b=KA7dZCr/T8JpCpS/3/XBgqY8MuvTYP9mJ/KfYCrj2Uzhb1LefS2+lP8WLSbTzhGzaD
         8RiFNiEREZAL9PRolRVMivCgMc0EDa4wUqqNlQqdGGBn6bcG394Ts5vZWmIrHe1fV4IB
         YXXJhfoZG91r9jp7T6DUpJRGZ51tO2hHM91RUYuNLt6SG+4DQaMRxF7O6KX/gy2H+2dh
         i1KrEpVXHHuCdFbutOIDAC+ZuUBBXhzRrdbF9E4ztJEbEwMSBBorGdBxqJUysiCvRMJy
         08XYrI65TCw+EVCEcczyQwBPdDGHlqKMhdUKXjQ6P0Pf7fCq3jyHsz9hkJdVz4H8G4gi
         wM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729587180; x=1730191980;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehh67ak1ioateKr68RZqUNIbd4XGcxrlqGgTaUiYc1U=;
        b=t6qB/DMXb0vMQVg+ZupIpqANQS4Y9/E/dQXLFP88cpBSXIx1XaTG7zxhXxXtS2H99f
         B6J3/cdW3bZT8yikPUo/wlvf3fbnSdr1wPlrGKKXeZ2OklMbwXbieOwJyjr08Gu2T092
         dECY38XbvNPZ3g+rFYaFfxiTXayj7gZV9JXkmUqv9ZfPrJ1vt7oQsvGeagaImLSNmK3y
         UGYt/VeAOFKfdgSecuym2Yw27g5GFiJj481/oaa5RCNf5CrbHBPV6cIEJJe9cKxVmcOe
         2PoVvrSvAZypzjBpbD8+XuixgW3hjD9wUeb383sdAQZVsWteep5nfE39W+WQfO/Uu/Hx
         Zfmg==
X-Gm-Message-State: AOJu0YzOFZw/rFjspns4figw58WHrejNdF4ExT50PFXwlGYIOliMy4c/
	GFgRHqirFclWn4N7Uod/sSe2VIp3ItFMvHsbS+DqxOLO5MoAmvf2Da89CeM7xis=
X-Google-Smtp-Source: AGHT+IEeYb2A3jr8YqrdcjMC3mNyRHfBT44BG5gmG0lVPBwfaz1SoYJI3Boer2F4765XuLo98da9Kw==
X-Received: by 2002:adf:f7cb:0:b0:37d:4a7b:eeb2 with SMTP id ffacd0b85a97d-37ea21cce0emr8687474f8f.35.1729587179847;
        Tue, 22 Oct 2024 01:52:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93f92sm6083113f8f.76.2024.10.22.01.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 01:52:59 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:52:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: phylink: add mac_select_pcs() method to
 phylink_mac_ops
Message-ID: <ef3eed0e-a4d8-41a5-888a-5333b340c37e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Russell King (Oracle),

Commit d1e86325af37 ("net: phylink: add mac_select_pcs() method to
phylink_mac_ops") from Dec 15, 2021 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/phy/phylink.c:1208 phylink_major_config()
	error: potential NULL/IS_ERR bug 'pcs'

drivers/net/phy/phylink.c
    1160 static void phylink_major_config(struct phylink *pl, bool restart,
    1161                                   const struct phylink_link_state *state)
    1162 {
    1163         struct phylink_pcs *pcs = NULL;
    1164         bool pcs_changed = false;
    1165         unsigned int rate_kbd;
    1166         unsigned int neg_mode;
    1167         int err;
    1168 
    1169         phylink_dbg(pl, "major config %s\n", phy_modes(state->interface));
    1170 
    1171         pl->pcs_neg_mode = phylink_pcs_neg_mode(pl->cur_link_an_mode,
    1172                                                 state->interface,
    1173                                                 state->advertising);
    1174 
    1175         if (pl->mac_ops->mac_select_pcs) {
    1176                 pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
There are two places where this function pointer is called and they both check
for error pointers.  However these functions never return error pointers, they
return NULL.

    1177                 if (IS_ERR(pcs)) {
    1178                         phylink_err(pl,
    1179                                     "mac_select_pcs unexpectedly failed: %pe\n",
    1180                                     pcs);
    1181                         return;
    1182                 }
    1183 
    1184                 pcs_changed = pl->pcs != pcs;
    1185         }
    1186 
    1187         phylink_pcs_poll_stop(pl);
    1188 
    1189         if (pl->mac_ops->mac_prepare) {
    1190                 err = pl->mac_ops->mac_prepare(pl->config, pl->cur_link_an_mode,
    1191                                                state->interface);
    1192                 if (err < 0) {
    1193                         phylink_err(pl, "mac_prepare failed: %pe\n",
    1194                                     ERR_PTR(err));
    1195                         return;
    1196                 }
    1197         }
    1198 
    1199         /* If we have a new PCS, switch to the new PCS after preparing the MAC
    1200          * for the change.
    1201          */
    1202         if (pcs_changed) {
    1203                 phylink_pcs_disable(pl->pcs);
    1204 
    1205                 if (pl->pcs)
    1206                         pl->pcs->phylink = NULL;
    1207 
--> 1208                 pcs->phylink = pl;
                         ^^^^^^^^^^^^
Potential NULL dereference?

    1209 
    1210                 pl->pcs = pcs;
    1211         }

regards,
dan carpenter

