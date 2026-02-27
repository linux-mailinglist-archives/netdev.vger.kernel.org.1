Return-Path: <netdev+bounces-261683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLlvDj8DoWlVpQQAu9opvQ
	(envelope-from <netdev+bounces-261683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:36:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A802B1B215F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39CD6302DF68
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67F2F25F8;
	Fri, 27 Feb 2026 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLOmXgkb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93A2D1F6B
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159802; cv=none; b=P2EKv1WEgXiMlhY/NERYhwQI20QU0QUr1HPW5JRGSDz6jb/cCx552ShNkpcxr10vfUkBR+RmBuEAq73zloWNBVifHELsPBPNfk/O+WwYwonAKycokZvnrRXKpWH7/d/a+BrUPUGQdoQCmX1B6rwGcJAp4LBKAmeIMZtM+RC+Qzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159802; c=relaxed/simple;
	bh=l+nEv2Y6FEb2oVcBaKlzWxtlJ3m0mj77GVOFIJR4dlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFanl7SSBzWByToaUjdz1ZP8QhM3U2xL8bth7BDSxQ4N9RMGHS4nGr3IchlrTVo+7Pwp30TXo+PrOMr2vPEdIlgt5nEJQRetBoJ+UpuB3Ohj/1Fck7ccT4dHcXV/GAFN8PQD74VhOBsvswkyv8/nVHw1p0ILCxN5f5/fyKyh/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLOmXgkb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aadc18f230so10043135ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772159799; x=1772764599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cTaHWVqVPPHKKO9lr97zROxv1lwqPfLhEfsjJzvUNbY=;
        b=VLOmXgkbVw22+QEGE+XkSX6KJWiPeDt+PEYtUsEeAaUllBPgJVp9ceuCEUCuPWn1A8
         YCpiUleE7ooUWvDU0ELG7NMAwYiJF4JCWwIs42hG8Qaxl2UCO4KY6rC4wQ0cWZ6lOMXw
         t140K5rgRwxWMW/j6tokXbzObhTzv/M872i9ujz+B8nw5fl57U+GSe7mcfciLXA6QhNt
         ylF6uBrGOuiMWmdWOyIfUgFcblpUudccoh9XMLrD9/jtnOfmN8ZN/lv68dLI2BOUc8g8
         JKD1nIaF4chwU4lTlUNo0UThzf4JVhQy8x1MgQGyQF1MqaAsndqiq3Ha9FfjZ0NUB9zI
         v36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772159799; x=1772764599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTaHWVqVPPHKKO9lr97zROxv1lwqPfLhEfsjJzvUNbY=;
        b=QyQ7g0P3AmlNqaUUE2d/F/le36dZCRIqimxCiuquF7lwlfEUgKSZdMRF3xwXbJek60
         NKMjXq4FJXI0AgzWgycpDuABBOb835g4Qr9AIE7t6R5PQ24lZslCxsGxMhPAkatHEuh3
         SxDZjjw2EJxZoH4ytFOMwPtVg6TNSJ+o6SMpbDlEB6fibzKzGopNDC0L6iB8Bsmsk7+j
         VN2uSixAcva9DV84hFVsUGkggTOXFOnNQQXDynGSGiLf+C6jmh9t9PwMrvI+3I2qXENu
         8SwCwRifNfLSL09nbvDG+1+RT5BGXdDMl6+CMCWMCqfFVhl88j3JAUMkja3ef0/Hha3b
         DDXA==
X-Gm-Message-State: AOJu0YyxhfMwi9qmQhaX+rgw2xu6u9u5qZLcjLBLdceBt/jbC2JzoR+k
	O6wPMoJQ7A7CwHdFi8YGs7h3TpDWb4BOQnqAgwYmL3h8QBj80/Nvdlti
X-Gm-Gg: ATEYQzwdBp9ErHvwLontK/lMK53tIhPHluiHAPKLpitwYnrE2Jjc2/mcGIk93sdx5gx
	W3DpzcfNECMUSIUvRg7a/RRGsIzN8SmllDkRYQcBTwtiA76fSY2fQToJCkUGnmI4WKZYURe/r0O
	IGteKSPDZBkfzsMqpzdo6APR5epsshAxQiF0jj9xmJQoVty27FzAGkkwGaXU4QcqzF5PckFuRqz
	qmYnXNGz/kYKwGIwba+NOa6whNNoTkhe5moegedEZSRP/+C/a87ylVE6u9jMUJupxGGdJGO+QWf
	Ctg1GQJgEkJ+fHK08u41GOdc3fcZKOT9O9M8LT1QFjufGCuqaTRXp7fIqLV8zIfypVOpxQzzQBR
	YJrpoAOmttw/YKljWyxKhsLlheyV7BQgg2wXY6ycukL6TcN44OedsjEpFUhAO6CYShYYSkx2bP2
	iwm1eIc5PrmM+tJBWBxPf77pFA4G0=
X-Received: by 2002:a17:902:ccc7:b0:2a9:db7:446a with SMTP id d9443c01a7336-2ae2e3ce5a1mr11578285ad.9.1772159799125;
        Thu, 26 Feb 2026 18:36:39 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b257esm38646095ad.4.2026.02.26.18.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 18:36:38 -0800 (PST)
Date: Fri, 27 Feb 2026 02:36:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCHv3 net 2/3] bonding: restructure ad_churn_machine
Message-ID: <aaEDL09GtkQnlE8X@fedora>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
 <20260226125331.28147-3-liuhangbin@gmail.com>
 <941081.1772152606@famine>
 <aaDq5vTsk8SW4bIA@fedora>
 <943602.1772156533@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <943602.1772156533@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261683-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A802B1B215F
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 05:42:13PM -0800, Jay Vosburgh wrote:
> >I added it here to help new readers and reviewers understand the logic
> >quickly. If you think there’s no need to include it in the code, maybe
> >we can move it to the commit description?
> 
> 	Personally, I'd leave it out, and just put a reference.
> 
> 	The churn machine isn't that critical, even the standards
> committee didn't like it and removed it from the 2020 edition of
> 802.1AX.

Oh, I didn't notice this. I posted a patch[1] to net-next to export the
churn state via netlink recently. Should I revert this patch?

> 
> 	Still, whatever we provide should work in accordance with the
> 2014 standard we're nominally conforming to, so functionally the patch
> looks fine to me.

Got it, I will remove it.

[1] http://lore.kernel.org/netdev/20260224020215.6012-1-liuhangbin@gmail.com

Thanks
Hangbin

