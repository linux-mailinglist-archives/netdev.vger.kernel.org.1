Return-Path: <netdev+bounces-274416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIztAMIjzmnElAYAu9opvQ
	(envelope-from <netdev+bounces-274416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:07:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D39385A07
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C662D300BD91
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7543921F8;
	Thu,  2 Apr 2026 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTQpA9pY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVcBCVhO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282A370D66
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116981; cv=none; b=lq2A9WfZy2AI/3avJJO5jL7NpOrQs2abDeear92gh+i3z5wJXyQoDQmC9kPBpW5MKBxjGfqQcZmeDBVU0kpy2w/CUnv9xsSzh5GsW+I8k5j8nYiWpcSWggxPDXKTkbjWSj30SKiyI+wXDIRogJhJtvG30UMdOLcu3tcOu7gF0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116981; c=relaxed/simple;
	bh=SIeZBntkQrxJlWn11//T8QiprFU/9gSEZnPVbEL8CH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1jxHPKqNjn8HRIpBjPlRRu00od6R9QKl9DtX6tNRGB/+e4qEip6e6unB9HH2mc93zRqxzxMWRXtqb9pM/hQpq2h0QSS4Wk3Inl7HGbX5swq6UXmlGH4O32E7tMQtqo7/vtmIKGtqHmHTvWNMcqsjPccJh1EVYM8gMP/qinP/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTQpA9pY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVcBCVhO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775116978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7fJDSsgKzepmvHd6OuEznxdID1T7eD+OBDnd6dxByg=;
	b=VTQpA9pYDcvb2LDldlATUnKyhLklXhc6joSdaBcoWflTuuNNQybK19yBznwJ2rtAyz/CRu
	yoO74YYBNfEChBrHC+WvvO1Eo20AshqgSqS9r7bgLehfI+2jEn3bRkDSYaBrjx7OlZScoB
	FAg7fAYlAWld4z+c7w+xJZECk1yCysE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-ibn-Zob8NROdjFPWwkC4Yw-1; Thu, 02 Apr 2026 04:02:57 -0400
X-MC-Unique: ibn-Zob8NROdjFPWwkC4Yw-1
X-Mimecast-MFC-AGG-ID: ibn-Zob8NROdjFPWwkC4Yw_1775116976
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d1bfbd219so834338f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 01:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775116976; x=1775721776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7fJDSsgKzepmvHd6OuEznxdID1T7eD+OBDnd6dxByg=;
        b=CVcBCVhOQmLtt1swbhPPi7ssjmEk3m2BiIKuPGcfUDnZyx4/XdF8IcTjgIPysXvqSm
         qtW181SCRPb1L2Fz58yLan6L4K5ISRzrwoIAq0zteI2wjZq/00dzckDPAM6JPgU52Phn
         NiAjV3iwXHqYRht30gNi8q+fvHcLSBIuREPZDMPCKo149I9xVq1ENyiAKzrDdip5p/PP
         1sho7KRPpDvNMVqkq9SGIanHR8ViV884TpeCww7F7npGXjUBLU3Cxn5z3Ju2R4SZyZJ5
         qV6T0R7AGBauEkPNgFY65AJKxnq0JJKkKH085gmCHhLKLnVI2x3JD2TzEt/aGxiqMP6P
         WTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775116976; x=1775721776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7fJDSsgKzepmvHd6OuEznxdID1T7eD+OBDnd6dxByg=;
        b=PUgDy0QvS3B0/xODCetxPBPK5Pe81PV9XQk0Av5qPN/J7nT15omKFMapnEqVLTJX7j
         kYj4Rwbdbp2SizbGRXtYRT9t86Q8tjviJBUoSdrSVwsTlQCYQ2MEbP6Fhn5e7xyazJ0u
         rtYF/CICgYn7Rl3l7eJ5Av49gJmEMIekxyKjbPOqUSYCeZPxJhBLhDpADlZJU6E3BHtU
         jjCx3aKali8vzi9uDExrRTkPDzpoOVdZpl45X2ivr4J2KDEgzI8ntTAO/eV/KQtBnEnl
         xr5uYf6hXjp+d0rBWHC4Ed1nfIH3L5y3T8FlHZ96OKtNRU6fo10UXeU0o+GqqD3yzUyM
         twLg==
X-Forwarded-Encrypted: i=1; AJvYcCXD7yooB0pDsvkj+praJTDqtxk74U2Q06GHUP+efwcqeZPh378GPlAOgPGB+a9b1wTS8HTLtX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXYIwwLbMtqk8v7ALmqozQgpJ4coazHKImjMuQnX1jhMlZ36Y
	f0MXUz/ZBeavdt7DTZ9lldLqWCJx8ZbCLdId57bN/RORKuv4UtXIomY338L12+CHyLK1UCSyOn1
	9KQFtoTn49zsiz3btxrfOf+8bRfGi6ysmpL58EZPYz4yMMw/LbjZqzGFkSQ==
X-Gm-Gg: ATEYQzzfW38ChzOzMUDJ+P7AQapaLGCXQfHI+9r1sLvt7MHUdDZNdrl3EaTN4vjZS6q
	nIlM4egSGh1Zye2Gip1suE/BMlxrwzcBWww7prkzc32rFs28XWf/tkA6Ni7vdOG3pyRwj4eyjWC
	JQot59eoENEhyJ9CyvyPGI8FgLVZqetZ12nh68t7CkUH1ms9Vxo9EJZu/MXVUUmHlQwIOcJYiaR
	n4Ucoosd4UmsVeUgKvhuLbv8bfoEngF/t25ky7jepkuKtwb911BhBEuoyTuyqabblMAG0sHbAlr
	tT+EHsMd45EktMkwnXDPAf9AoSLihhSYHrF5BxTtK9pAyexENe2xvZAu46v56p2CGMQfY+AwNZ8
	0SUtFeDaudoOJzrog7kfHQqeicHTyrzcVDhC2j1jskyEhKSByOVUHPX4mLg==
X-Received: by 2002:a05:600c:4fcb:b0:485:3e20:4013 with SMTP id 5b1f17b1804b1-488835d539cmr113656415e9.28.1775116976106;
        Thu, 02 Apr 2026 01:02:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4fcb:b0:485:3e20:4013 with SMTP id 5b1f17b1804b1-488835d539cmr113655715e9.28.1775116975567;
        Thu, 02 Apr 2026 01:02:55 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a72baa8sm50011965e9.15.2026.04.02.01.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 01:02:55 -0700 (PDT)
Message-ID: <e769aaaa-17bb-4356-9848-dc5001885e24@redhat.com>
Date: Thu, 2 Apr 2026 10:02:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v36 1/8] eea: introduce PCI framework
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Dust Li <dust.li@linux.alibaba.com>
References: <20260329132222.130912-1-xuanzhuo@linux.alibaba.com>
 <20260329132222.130912-2-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260329132222.130912-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-274416-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55D39385A07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/29/26 3:22 PM, Xuan Zhuo wrote:
> +struct eea_pci_cfg {
> +	__le32 reserve0;
> +	__le32 reserve1;
> +	__le32 drv_f_idx;
> +	__le32 drv_f;
> +
> +#define EEA_S_OK           BIT(2)
> +#define EEA_S_FEATURE_DONE BIT(3)
> +#define EEA_S_FAILED       BIT(7)
> +	u8   device_status;
> +	u8   reserved[7];
> +
> +	__le32 rx_num_max;
> +	__le32 tx_num_max;
> +	__le32 db_blk_size;
> +
> +	/* admin queue cfg */
> +	__le16 aq_size;
> +	__le16 aq_msix_vector;
> +	__le32 aq_db_off;
> +
> +	__le32 aq_sq_addr;
> +	__le32 aq_sq_addr_hi;
> +	__le32 aq_cq_addr;
> +	__le32 aq_cq_addr_hi;
> +
> +	__le64 hw_ts;

Sashiko has still a lot to say about this series. Here:

---
Is there an implicit compiler padding issue here?
The field aq_cq_addr_hi is a 32-bit integer ending at offset 59. The
immediately following field, hw_ts, is an 8-byte integer. To align hw_ts
to an 8-byte boundary, the compiler will implicitly insert 4 bytes of
padding, placing hw_ts at offset 64 instead of 60.
Depending on whether the hardware designer intended the register to be
at offset 60 or 64, the driver might read from the wrong address, or
rely on implicit padding that could change across architectures.
---

I assume the (virtual) H/W does the align thing correctly, so no real
issue here. Still replying to this patch explaining why the raised
concern is not valid would help a lot progresses on this series.

[ ... ]
> +int eea_device_reset(struct eea_device *edev)
> +{
> +	struct eea_pci_device *ep_dev = edev->ep_dev;
> +	u8 val;
> +
> +	eea_pci_io_set_status(edev, 0);
> +
> +	return read_poll_timeout(cfg_read8, val, !val, 20, EEA_RESET_TIMEOUT_US,
> +				 false, ep_dev->reg, device_status);
> +}

Sashiko says:
---
Can this cause a 60-second thread stall during a surprise removal?
When a PCIe device is surprise-removed, MMIO reads typically return all
ones (0xFF). If the device is removed, !0xFF evaluates to false, causing
the loop to never exit early and hanging the executing thread for the
entire 60-second timeout.
---

A similar concern was raised on the previous iteration. I see you
decreased the timeout from 1000s to 60s, but 60s is still a considerably
longsystem hangup. Anything above a few seconds should be considered
carefully.

> +
> +int eea_pci_set_aq_up(struct eea_device *edev)
> +{
> +	struct eea_pci_device *ep_dev = edev->ep_dev;
> +	u8 status = eea_pci_io_get_status(edev);
> +	int err;
> +	u8 val;
> +
> +	WARN_ON(status & EEA_S_OK);

Sashiko says:

---
Does a surprise removal trigger a spurious kernel warning here?
A surprise removal forces status to 0xFF, making 0xFF & BIT(2) true and
triggering an unintended kernel stack dump for an asynchronous hardware
event.
---

This looks valid to me.

/P


