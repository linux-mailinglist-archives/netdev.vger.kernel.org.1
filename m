Return-Path: <netdev+bounces-263218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGs3LiXopmlWZgAAu9opvQ
	(envelope-from <netdev+bounces-263218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:54:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C11D1F0CF5
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95C87305D935
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6B322C99;
	Tue,  3 Mar 2026 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Qcdy9quO"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA28329E4B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545677; cv=none; b=sXidutvRxu2cPFYR3VHHhNJOcKczBJswLDso4rhbmPMldv3yDuftXhEHQv716fhhjRi1kIps+t6DSKhT/2hcGnwHv0P1wjhj8g36jXT5idXdvJFpuk56ZJfOjg6bEFrJ3+JVB7CTnpyqRuzvRNEqXvwSvExFMcmKys209DdrC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545677; c=relaxed/simple;
	bh=rDF64gKNrFuJR1ghudzEfBGmuMKFrjdHY/W7EjEH27Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hprZiMyKCv+iJv38rw+96Xb4taTzUo3b0XhnRK1ClaCD7ZJN2di4aK9LMe3b0Jh1OaBXUGQJS/lZaEtu+Z818O8McQFcL0xCoQCnLqqNd6//xL/wmAWjeC7h6NJVVGKkGmB5FHNWeikNFS5akQxhItnGfU9BDaniYoweOvoG8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Qcdy9quO; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 90eb9c9a-1707-11f1-89dd-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 90eb9c9a-1707-11f1-89dd-00505699b430;
	Tue, 03 Mar 2026 14:47:48 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 90ebea25-1707-11f1-b5ce-0050569981f5;
	Tue, 03 Mar 2026 14:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=xRkkD1OXu+YPb4GG7AYe5WtbGna1MLUeF9HH/erQNQY=;
	b=Qcdy9quOGbMYrYsaWRXDxktptM6vv4IAHZkJFhYSpL3oW6VjMFE1B33WH9aTSgUSMYDo8JWnbZ/U6
	 DIJDC17+2Xw8+a0iwyot5mr5yVxJBrdu4i+dtEdNudmvz5zz2TkvluBmD3SULsJV0WQ5vxfGU5YNBS
	 ckPSjTbGtjEUKsnQ/x8UMW+Q9SYOMgM2uv2mOeEYS23bt1GtLpfTEGJ3LzrjqqIJKjbcuZehDgDOk9
	 SSAXIQ7VJRdj+YdFDkH4MQauiSjNDlhpc+1+FIO3nulPOturlXMiDPg5n5NhNGvo4Q9FNG45o+Ny90
	 dPpuNQ1iebh/4Q9r/3NGfSuA5AYFz/Q==
X-KPN-MID: 33|ZTKJC4Mo9CiQfSsq9tDxgNPeveSvSfwZeqsyspmXV7CjOyw4pr0QHJwbcrbHub0
 iNQbDVfwYShgslr66bz5cIOjK0DUHQB9dMwlu7zhkg9w=
X-CMASSUN: 33|T9nminXh0jUeDWRQhThNE8ev22cVTZRJrA0yzmZDbFH4vT7zt87zzYKSrYmrb/s
 /fMmB5mlK4193IZHUc52GHw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 90dd9f29-1707-11f1-94b1-00505699eff2;
	Tue, 03 Mar 2026 14:47:48 +0100 (CET)
Date: Tue, 3 Mar 2026 14:47:48 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: 
	"open list:DIBS (DIRECT INTERNAL BUFFER SHARING)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Message-ID: <1277375914.227884.1772545668781@kpc.webmail.kpnmail.nl>
In-Reply-To: <9354017b-36d6-4001-a28b-a3f777506909@linux.ibm.com>
References: <20260302163103.3324304-1-jkoolstra@xs4all.nl>
 <2026030246-savor-hardener-6102@gregkh>
 <b4804b53-c25c-485e-8cb3-9ade70a6f625@linux.ibm.com>
 <1787125475.222946.1772544235267@kpc.webmail.kpnmail.nl>
 <9354017b-36d6-4001-a28b-a3f777506909@linux.ibm.com>
Subject: Re: [PATCH] dibs: change dibs_class to a const struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 4C11D1F0CF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-263218-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kpc.webmail.kpnmail.nl:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,xs4all.nl:dkim]
X-Rspamd-Action: no action


> 
> Thank you.
> Would you mind sending a quick v2 with the link, so netdev maintainers can take this?
> 

Sure. How does that work with the reviewed-by tags? Do I have to add them
manually to v2, or ... ?

