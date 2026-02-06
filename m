Return-Path: <netdev+bounces-257554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA0wJJTvhWlvIQQAu9opvQ
	(envelope-from <netdev+bounces-257554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:41:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA58FE510
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FAC3307AB00
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4863B8BB4;
	Fri,  6 Feb 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yB0O91Jg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BFE3E95B6
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385157; cv=none; b=J0lqDVxyToOm1YXzIYk1tVLCtOCe/zrOTYgkb/1+LG397Uzvzmi81SJKpq8pPvA6FSN5ZI5Y9v9zQph2RyiDJsM2aljfovsA/j+RHWVIZru/kIa9Ugko6d4q9Pug+GrnM2HjC/V9pB5vQrH3t3Udqrr0DXGqLAniZyVTnISU/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385157; c=relaxed/simple;
	bh=YQ0XkX+7IHhyPfDazRs/Y+8VRB6879z4/kNcHXjWDc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WP1DTyYigqK9BmVGL6Q5iqsujhKTNsKk1ee13UMegRuNeLbKLoRh2rLY3J8vO7ADjwiA6T7sXd3q1EEqW8xVSYbTXlJeHHInCH6HU/AcY/Ps9TCakiISLKDMQBQN9MS6pOou1ihAXeMIImJEYB19qALj/ZQ2HJQxcQ0BAGKqrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yB0O91Jg; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4362197d174so1351667f8f.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 05:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385156; x=1770989956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xktNeFfMDcufE5X/S0bJkx8CgzqCPcdz5dELVBNTvag=;
        b=yB0O91JgHaUw3Zy1J1hrVVLtsDUXgm4sbr8F58yDtXjW/nawLfMy3OskiE22oGNknv
         CKSNtoUJ1R/dLVfHsKsyLH0fRokVEfU96Huh5Xs9T/Naa+GT2Fi+DocMKu+dD+DKY8vv
         AAzFtIHP7d8VY1yDUYkGxGaxt8b0CLvZvTNAEP5NraWq9tq/sOkARxKEQn6031i0jNoT
         AQA4bD+TYB3+z3lafrcSKArQEkdsQlGamyEPyM3Sio9ChcC9lP3czBjIBqaEJgMCjpGp
         JfBeiVVhuu056UqM+TqduBedMlAaXF9qZiTvjN9Vtf0pjVpPTQuEQvIIAioy56Au9GyU
         nniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385156; x=1770989956;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xktNeFfMDcufE5X/S0bJkx8CgzqCPcdz5dELVBNTvag=;
        b=Yuc3zHxTX9UCa4gWGkj4nLD5dDK/Ix8EnYn1KsI8EuHkcFb9TwuHEXB2j4lFXmG2Tl
         i3Cv9UF5OH5a83we2V8wIg6zKn0KbfkUWmIHwDm2fYNqiWMUcOIylh+d/IQB83WyC8ca
         6fGA2bGkiT8IYC/VOZZ/WmPkl2CCGWClxa+FFumY5/0gSTWIkwZZqzmFnWLHTtnWofDA
         Kpg2UOvFFVSYmerSVghCVFe5oMvX6fFsHxmgAv8jSbjZUpQ5v2NmWfDxCN/l9LUUgwOX
         1LjUwx7Qy9KQ2DQ1yov2d+6vCrVg9EgVsCEtKr65i94hLBbh7VUxdqjNca0sqRrFKCOK
         9C6w==
X-Gm-Message-State: AOJu0Yyek+2k7bRJ3iw4p/7gspc5CHwfIeltR+20q6KovOVr9UOSKE2l
	qU0HaJYhN0DrC1ISa7otTdc4w1U2Nds5X1b6/eqYo/WxuYKg85JsJ5wduCgj9II0MFE=
X-Gm-Gg: AZuq6aJTg/5xYihAo2LQIdVJV5Zee7LGGzeQrvUVcsAD3vfei/mtqniQVbhltAapCrK
	mjOQ9Lm5uSR15M4M4BXVBIhspl2qlWB2AvJU+X7Pnu2F/xTiKoFnUKfOMANPSpR09gGoqhZ3SPu
	cSXzoHQJUDF3aJ3LUn+2i9BRiDsh2ywMn8YAwkg+bU9d9Oi4R0fa5XtLtT0NbBMv3wSRFuIQzN2
	zk7w5u7CotQegQNtELrsVJte6pfAv5jw+oMTm65RIm7MZKkFJcbr0Z31rYSyrVavADB5jkjbhMO
	1p7jLZfWrKfE/Y57VbacXM2sITirt4mXv3VTdY9/qs6pbVQNJRSxRBIpGEEOwZltJl24S5Dw649
	1OihGkK5jwOKXHzXcJVMujkbd1IIxpTRBNP3RVbQJv3vqXgPQ/GQhjhpCbuAvDRAtd4bxFAQpLM
	Zo/He2eEYWGtwOcKBQ
X-Received: by 2002:a05:6000:2012:b0:430:fb6d:1442 with SMTP id ffacd0b85a97d-43629386018mr4933601f8f.62.1770385155422;
        Fri, 06 Feb 2026 05:39:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd3b8sm5888949f8f.11.2026.02.06.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:39:15 -0800 (PST)
Date: Fri, 6 Feb 2026 16:39:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] net: ethernet: ti: am65-cpsw: enable bc/mc storm
 prevention support
Message-ID: <aYXvAC64pI98jgdY@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257554-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,stanley.mountain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EA58FE510
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Grygorii Strashko,

Commit 5ec836be11b3 ("net: ethernet: ti: am65-cpsw: enable bc/mc
storm prevention support") from Apr 12, 2022 (linux-next), leads to
the following Smatch static checker warning:

	drivers/net/ethernet/ti/am65-cpsw-qos.c:1126 am65_cpsw_qos_configure_clsflower()
	warn: iterator 'i' not incremented

drivers/net/ethernet/ti/am65-cpsw-qos.c
    1118 static int am65_cpsw_qos_configure_clsflower(struct am65_cpsw_port *port,
    1119                                              struct flow_cls_offload *cls)
    1120 {
    1121         struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
    1122         struct netlink_ext_ack *extack = cls->common.extack;
    1123         const struct flow_action_entry *act;
    1124         int i, ret;
    1125 
--> 1126         flow_action_for_each(i, act, &rule->action) {

This loop only iterates one time.  Is that intentional?  We could
use "act = flow_action_first_entry_geti(&rule->action);" if we just
want the first entry.

    1127                 switch (act->id) {
    1128                 case FLOW_ACTION_POLICE:
    1129                         ret = am65_cpsw_qos_clsflower_policer_validate(&rule->action, act, extack);
    1130                         if (ret)
    1131                                 return ret;
    1132 
    1133                         return am65_cpsw_qos_clsflower_add_policer(port, extack, cls,
    1134                                                                    act->police.rate_pkt_ps);
    1135                 default:
    1136                         NL_SET_ERR_MSG_MOD(extack,
    1137                                            "Action not supported");
    1138                         return -EOPNOTSUPP;
    1139                 }
    1140         }
    1141         return -EOPNOTSUPP;
    1142 }

regards,
dan carpenter

