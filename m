Return-Path: <netdev+bounces-257553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI7zK6DvhWlvIQQAu9opvQ
	(envelope-from <netdev+bounces-257553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:41:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 532B6FE526
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8749306B086
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B33B52EF;
	Fri,  6 Feb 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xf9/ywN4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98BD368279
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385116; cv=none; b=TiLHCmAA/LM5OnoePQKqD3N9mR7qlz+v5JzS6b6fZzW2xcdRLcjAPCoGj6wVLRs8+Vlqb8qHpij7eVwXWoKFPVm/ODijayCxqi/G9E0YS2ZkVzsVgkzsu6urFAkuayK5rYN/vcJ4W6mrPiCGOTLOJYz0xqSYV+xU7mpYx2gmVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385116; c=relaxed/simple;
	bh=CsRZyI/0CJXBnCrb8NeeHp8Pz5Znjh8bovcxhtKVDLc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RRFbo6STEycdHDoeUSe1ei2jmG+k5fXimdwsT2BMbQAG4gn80+wxiJceyt4NeRfKqX0oGJzCyIHSVRmcUwwB2vhcXw6Y5GlzDZZvOn36qDpnWLYoQTB2+3RypEmrJzXl7h5M7w7wMSnOhJrt9yiM+fKUe1+fCfF32m3EPKFLHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xf9/ywN4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee07570deso6509035e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 05:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385114; x=1770989914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jGaf7RjpOPMSJQSv1pfAOB/0Xi5hMSSLw6Z4u1Ofeis=;
        b=Xf9/ywN4JZwLuP3yClISFRfliTv77pLrEeraD7uYfNeyVQwo7cdqc2fa5R8aBeX0+m
         kmv8wuuJm7yU0qSrJ0Oh8XfUijuoxT8jrctzuVn41pFajuT/P0XCxenxYDIqsQFEgODd
         kPjNhh9iSA3AWdZG9Muz35kD31ls08Nn3FMhSc0LR8kC3/i8tBEhG4YHgPs0Q5Hfkqgn
         816nlVHgr1tYw0EjZvcTWBAxUyF+JsCRcyrn0mMiK51gTC6oBivYk9/4t4mG5BZcE0yv
         DfOmLk3kL0KgSTXW6cgXOMnyLNklG8ArKdySRqmsl/o0JlVuIVspVouGXfAZaYiCgdh/
         wIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385114; x=1770989914;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGaf7RjpOPMSJQSv1pfAOB/0Xi5hMSSLw6Z4u1Ofeis=;
        b=lAXYZWIGsYJfiJqRjEDRj5Dj9OPC1u+MYjfaClcv7zxjHhwiWOv5yxSGkrUnw8rqZG
         Y6dM8aU82FURxiQGBlClAeMty3cix0OMGitV9KvptxaiKC2P/B4uP4qiExJ1E553fUl7
         nYizvyTFo8ee4Q7iJBaMwfVy91xhNNCvNiW3LK5fNY2g7xJb1rW/eHxIVKCAhNfI2plO
         4HHCFywxMuancacNs7NWRCpuqUYOz+Sx9AktN2Hfba3w5oLhG0AsuKqUHrccLUZn4ywf
         156Xi9jRQdoxFKD0LQfq7O9Tpv1FJ/tBYMy1ugPZFAOoVdbFbUkuQVnZTl/QkwNXJ9fG
         lWmg==
X-Forwarded-Encrypted: i=1; AJvYcCUp5a95bzjCAsMpCKgzCTGWPLylGeu3ApL8q3XMOyz8Puu+nPDh+1aP9qt8LxfKImEsy8jENFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuW7W2S5A5uR/awteIc8suozy0u5gRMTTtHoF5AvXlBnHKs4Y
	tGrZe5fIAZi/8SIMo4KA+7IzVLLTqeQAzrcHj2Fbke/86UB6Y+uvQYQ3rgl60tOw37Y=
X-Gm-Gg: AZuq6aLkZayi8AeuAUWlPLODCrbaBtIonlYaRQz9+mitKukgzR1MDepkMm1hgxgAB3F
	eN7R/jzjmc9qChTSKG8oAcdKdUzuvSJcGZThFtCpauGuKWlD27X0qJqgfwsQww4xqz32AqjgK5S
	t0/kdYiPzXLYCc3PPGb+Qn6ZEhAYTMoXu6vewT/1z1lYBOqhzaa3a5CMiFvG97cTgywWuxWiFC5
	tsOa7HnQGrCCNotq/+HiQllfW3XxugTq0+b4EMHuZVam2m6WG8ohohI5b7vFU64rMPQF1vVLNdN
	JQ3/jIUCORDx/F2V3j3qAdHyqg/K4vVyoBf9jjmJ9yGL5JkFvCa8lEh/7L7PxyKN+Do9viMclBk
	7rWj9jxAN+WPAqWgRABYl0ewTiJgV1YwkGgbWbHI9uhG9rX4UpyXGiHHTUJIrSSrlo2gkKm+DLm
	RSY7AgygDxZoyH+jKV
X-Received: by 2002:a05:600c:8b88:b0:47e:e20e:bbb0 with SMTP id 5b1f17b1804b1-483201d9fa8mr40917305e9.6.1770385113871;
        Fri, 06 Feb 2026 05:38:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2bab2sm231973995e9.3.2026.02.06.05.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:38:33 -0800 (PST)
Date: Fri, 6 Feb 2026 16:38:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] net: wwan: Add Qualcomm BAM-DMUX WWAN network driver
Message-ID: <aYXu1uXRG1KHrKej@stanley.mountain>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257553-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,stanley.mountain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 532B6FE526
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Stephan Gerhold,

Commit 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network
driver") from Nov 27, 2021 (linux-next), leads to the following
Smatch static checker warning:

	drivers/net/wwan/qcom_bam_dmux.c:505 bam_dmux_cmd_data()
	error: buffer overflow 'dmux->netdevs' 8 <= 255 user_rl='0-255' uncapped

drivers/net/wwan/qcom_bam_dmux.c
    500 static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
    501 {
    502         struct bam_dmux *dmux = skb_dma->dmux;
    503         struct sk_buff *skb = skb_dma->skb;
    504         struct bam_dmux_hdr *hdr = (struct bam_dmux_hdr *)skb->data;
--> 505         struct net_device *netdev = dmux->netdevs[hdr->ch];
                                                          ^^^^^^^
Smatch thinks skb->data is untrusted.  This is the rx path.

    506 
    507         if (!netdev || !netif_running(netdev)) {
    508                 dev_warn(dmux->dev, "Data for inactive channel %u\n", hdr->ch);
    509                 return;
    510         }
    511 

regards,
dan carpenter

