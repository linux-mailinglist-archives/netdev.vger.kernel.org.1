Return-Path: <netdev+bounces-263207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMvxESfipmlAYgAAu9opvQ
	(envelope-from <netdev+bounces-263207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:29:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B95881F03BA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD74630E4A07
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B2E39D6CF;
	Tue,  3 Mar 2026 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Lt46NKK7"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82C426EAD
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544243; cv=none; b=qMUHKdeDIC7hSEUak2Oo7R0CSflgYMk4blXFvt5lQpNs9KwEUsKO+uLtqwY+ipTIk4EyGN0oygTSvw1fCIsgTIpWfvcW0DU19Xi8e3d3J9bDuwswwBtkkZoQIHz11TemhNNY3dzAASyIsJ5XO6LiKktUL4BKJWD75lBf4RWz3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544243; c=relaxed/simple;
	bh=mxEJh++ORjPtHJhNSRW2+jHvlU5fkP6Q/PC2E1J+bcY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NBjXL9cTPYqbPki7/OMdZXBt/ZPR61I1hZjvuN5CcMCkyGZeBlPI++YMsHHHRn2oqG23srCG4D8zNvFplPyRD25+pnKCaqTZVgusuwcfHuDAQ4gXFfiHTReU+aUx1/OgO0hV1WfH3Dn/aIZFyO6Y1DRkRSqyTJv1PbspCz9fvvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Lt46NKK7; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 3a780c94-1704-11f1-afd5-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3a780c94-1704-11f1-afd5-005056994fde;
	Tue, 03 Mar 2026 14:23:55 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 3a76ec76-1704-11f1-83d4-00505699891e;
	Tue, 03 Mar 2026 14:23:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=ylW3O/pSrSR3YafEdqlMn9+eER3lS4nH5esxRzdgSzs=;
	b=Lt46NKK7xW1qXDVOb7vtuVqp5IgpIn00soDC8aVDeWI9KWYuwD7kO90AOLioR6o4YWHkASlsy0VRE
	 VrPQivYAQYtg52AAsE5NfSfXRZoTs9FRVryJcmZ6BgLzhMRRDEdJ9+W8yziYib9bPYnSztJH9f+emQ
	 7RDPow5DQmWNGCuYXImdnzxfgkyyW373+CDgnFiwD6pO93sXdGJn3L6jyCX5SkauwhtEHOBkc0Y967
	 wzPWxrKTjxk2PV4kB6bTF7Nvmt2ITaCBTGGp/P6g3aJkXjvHr/k9/McxWuj+vbkDnq5l16N2OxONK3
	 JKFdbuOESdMGLoWEp8p+BhTBy6n1uaA==
X-KPN-MID: 33|1RmVKGg+OMjyUl5nfPJlF1kgNbg2BmiXjH6ATKO4FJPBgAxYxYUFgvTIXTPJ/Hz
 kFg98mjMdpwEN2dcFeGQ3RrTkBL4nHV5MEbTbjXUT5As=
X-CMASSUN: 33|IKN2CCa3ZcXzetgOTgxkagMLPITjPsWayu5Xwg44M6Z44m++N2Ydj5P1FtibBo9
 TD+9bfzMcxEnutu7YNCoNXQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 3a6cbc8b-1704-11f1-b8d7-005056995d6c;
	Tue, 03 Mar 2026 14:23:55 +0100 (CET)
Date: Tue, 3 Mar 2026 14:23:55 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: 
	"open list:DIBS (DIRECT INTERNAL BUFFER SHARING)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Message-ID: <1787125475.222946.1772544235267@kpc.webmail.kpnmail.nl>
In-Reply-To: <b4804b53-c25c-485e-8cb3-9ade70a6f625@linux.ibm.com>
References: <20260302163103.3324304-1-jkoolstra@xs4all.nl>
 <2026030246-savor-hardener-6102@gregkh>
 <b4804b53-c25c-485e-8cb3-9ade70a6f625@linux.ibm.com>
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
X-Rspamd-Queue-Id: B95881F03BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-263207-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xs4all.nl:dkim,kpc.webmail.kpnmail.nl:mid]
X-Rspamd-Action: no action

Hi Alexandra,

> 
> Thank you for the patch Jori.
> Would you mind adding a link to explain the "as the driver core now allows"?
> Maybe
> Link: https://lore.kernel.org/all/2023040248-outrage-obsolete-5a9a@gregkh/
> 

Yes, see this one indeed:
https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/

> 
> For my education: How could I have noticed that class_create() call has been deprecated?
> Is that marked somewhere somehow?
>

I think this is for Greg to answer, but my guess would be that you maybe could
not have. I don't know if there is a formal deprecation procedure.

This is just cleanup work that has been laying around for a
while and some beginners like me have progressed this to gain kernel patching
experience. I see that this was already being worked on in 2023. I am now
removing the last references to class_create() in drivers so that the API
can finally be retired.

Thanks,
Jori.

