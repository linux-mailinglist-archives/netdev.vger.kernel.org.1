Return-Path: <netdev+bounces-288296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCPyNC8UB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:40:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2124554FBF8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 273F0307C56F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CED3D5661;
	Fri, 15 May 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="FQ46LVKu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2146AF06
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846783; cv=none; b=RBpNcLRB78KTmQ8lxmTbfrcfZ1AaArKDy5+bdK5ddNW4Nfs1u759sUCHYVwUiMRbK6jnH/OZec5LDu9HElynyGm03iMN+lYEEuXiIU5OEmtHFkh58ycho3EmwUT2JrY1VD8QXV9g6OkapdiKCrSfeTN9vRE5h336fpe7+TyQExY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846783; c=relaxed/simple;
	bh=+dNIOYfaYeLasDxxROiU1UR+UWb2ChD786sy8A+6Bh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbOMXsP9Dk6p6zn1HlVm4JJtUFI0ttwPMARGsjPPVYlV5Xe0mB9/W/ieHppP6aP6TmTZuWHByMf7Nh0UKnv/zjlfpfhAYYFy01fh/pJ0+gR4WX5FfG1AQyhrIZGFa35GMBBqTC2/uiXoDJ3bRwtuQwA+0ymZtXeTV0rApVGJPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=FQ46LVKu; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso8050323a34.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1778846781; x=1779451581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qicasEP/CfEOnCGBWu5Dle7NrU0UFR/H2IjNUOjDzk=;
        b=FQ46LVKueUeRriKbjBNrrJh5F4+Av3PSut1WxodA1N4TVSbbQKHgcrWkIkRu7V8mNZ
         7tII1/kJZFpciEHC3RQy67sjfx1U+1Tf3u3c9ksOZwswZE3AXTUV5MxzhG+hZvY9Gx9A
         DJAhwmUY5A0x/JD7t3iysV9QYv7jAHMYurkj2jxM6O5KpR6RlLK2TVMeefct6DVSJC/f
         rR+Rhou1euPLRXDdePjJAzYyX9Pi2JUmVmrz4WigFZn0DS7tXQ63IPY43IC1PNoPKDv0
         lGOm5+dlmNqChqNlKbU9HirXhFwJuKbdgFGsP0OLkJz5nbkx8jorVxAsyXyHbGHP+dEM
         Trrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846781; x=1779451581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qicasEP/CfEOnCGBWu5Dle7NrU0UFR/H2IjNUOjDzk=;
        b=b5xUYbX3Tgzv2GvsYVNbFRAFcDFYT6Gn2L2lj78Lupr4WCouo7dFLpRrKsTLgjw6l0
         AjFvlUPA4WI1WGLi1mSJu1Y56BfdktMDsShrGT7ZIV57/k5naSNpluaXSZ+nUi7W3hvn
         /wOUPyrwrhnSxZJxGfykOm/fPb6dp4j/lGTuT8ZZSXPEZyCiUHgyEURp5CXtG8G+/hGV
         4RCvQZgl2dFm+8NlZxrOarZOGMwMdDGpGNrbloa38LXa7zMQy282fJPgnUwghIlX5Bvk
         ZIoEHNG7yo9dt8wlF4xFR6obyFYXEJ/Y0jt++wj2qceqofLkX1yY3eSULnA0kaLbEGDO
         cF1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/AgHCK5m0XiEsvpnOJ0thKOcxrZdY626JZ984y9XA3hDn6bnTQ16RuZjHoFZG7d22WqO7A/hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydO54+k0mNr7zat/2utd8ShXQ269tpH5IiYTaDsP/PoEjifk3i
	tO3B5VcuYX9KbqmgOEm7rPT1ZTHYhCBT237xdWl0AujRSwp1xPqf7LIu/ByyPlkCezw=
X-Gm-Gg: Acq92OFJPXHBgJIUoJKVmnugwQ3h9B5CIyzONEELB74RbEFSO5w4TV9/e1d1WNfTkkb
	Pas61zSxNDwaPODA/ZgFee52hANHOPaUBPKl9g1Zf98ndmicDGCcegvfiNQwl+1fTMZCV3j2092
	9eWYwNqkzdc7rt7aLXUcKNWNFpKrLT+tPoO2K5Nn8kqWGfavUmVrmQXcaip4s60KuIdZz8EWfVQ
	l/172X4D8w1RuUA1CVFkZiljW1LcmhHQ+Xb9R7eJA4m57jTaQVfoxSdbrWbhWFpXjpkYg3itm9q
	dehUbgnD5UMVa/QTPHon1yGtlRbmdVgx9COzGK7GDDCusnjydtDqS3YPjBmaHY1Myb/xbu09KK0
	ADwTlbtiZYw67rRQp3z/qi9bsYUWkVXIj/xbQ2kFh6mHz6NEmqwe7XXL56WBRG8Y14K0hYnWUif
	fJwuoNvFMmXPS6n4RTyH5F6ISO4geQxEcKMUpT28yWG0z1d5u4SNAnV1/hLSUuvYK4WFlocnvCN
	YgHbSMqR+52RRM6JmLPTQoAlQo5R7bYBge+rQ==
X-Received: by 2002:a05:6820:2203:b0:694:8646:9927 with SMTP id 006d021491bc7-69c9437c542mr2221494eaf.35.1778846780895;
        Fri, 15 May 2026 05:06:20 -0700 (PDT)
Received: from fedora (d-zg2-146.globalnet.hr. [213.149.37.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba1825dcsm527575185a.2.2026.05.15.05.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:06:20 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: phy: micrel: use dev_err_probe()
Date: Fri, 15 May 2026 14:05:40 +0200
Message-ID: <20260515120608.706361-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2124554FBF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288296-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[sartura.hr:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Currently, during probe defferal the driver will print multiple times:
mscc-miim e20101a8.mdio: Cannot register MDIO bus (-517)

So, lets silence that by using the dev_err_probe() for printing the probe
error as it handles probe defferal.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/mdio/mdio-mscc-miim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
index 944efd33da6d..259944d37fbd 100644
--- a/drivers/net/mdio/mdio-mscc-miim.c
+++ b/drivers/net/mdio/mdio-mscc-miim.c
@@ -330,7 +330,7 @@ static int mscc_miim_probe(struct platform_device *pdev)
 
 	ret = of_mdiobus_register(bus, np);
 	if (ret < 0) {
-		dev_err(dev, "Cannot register MDIO bus (%d)\n", ret);
+		dev_err_probe(dev, ret, "Cannot register MDIO bus\n");
 		goto out_disable_clk;
 	}
 
-- 
2.54.0


