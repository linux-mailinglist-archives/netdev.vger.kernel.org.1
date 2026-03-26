Return-Path: <netdev+bounces-272249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNzYBLybxWnP/wQAu9opvQ
	(envelope-from <netdev+bounces-272249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:49:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9266F33B8DB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 454BC30097DD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC0631813A;
	Thu, 26 Mar 2026 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9RwWnxw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14B23C51D
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557967; cv=none; b=nIJlDa/QGjQ1kp2AnoOot2Vc/hNP5lsFHjJGSC8vbk7YDVl3Nzva6j+i953BPzftTho/acqnqf1waYRsUd7zeZtl24dGOvDtNHYTiO5s55kKE6CReBn5RNi+L4RIGOgOgKlo8eLVqE59OgiBml8jdndQ+vuZmJ15evWHlgspK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557967; c=relaxed/simple;
	bh=83x7B15JU0eBjWrma2oJZDU/Ll6zKt/qnyJYDeXGjCQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XaFf2lSq/x1Kz00iJ+BJP3DnRJ5ev5j77a5Zp9qVgX9cnxAQkrOsCV3STcVHvQTjpGUeb5Asmf0Ae1Knt/BI7o/EWx+8P6pz83b+718XIcgmXwdInZssJLvdbgyAhHWeh+XmYkKPg3nmjmwSCNmJoxdbKMPS4VmpVFHGvsUqJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9RwWnxw; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a60975dc5so15706317b3.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557965; x=1775162765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLoJB0eAAHhKa/CHXdOXvJXrrrhW0QZ8tP3OfHcCcRU=;
        b=b9RwWnxwl1viA3iQzElt7C/PbP64Ol7fQQ++7ibL8mxANLKYH3Co3CvDppxwtSwztQ
         d0j3DLPvTWL1ZNBwMVcjQaVjSHyRMb21K2q3memWyWVjSGTBUUy0DSOnJyYB9uaLR8Le
         Dh+jDW6xfcInyx0ghypSV/VbpTfaJCpUOzAMvNCJ/xc1Gx2u6bLoFnLlCn8wnHwV4BKo
         Rda8D9Ia1b+YO/s6hGNH6+qdDr4xgNGVNyscbS2LTW8mRM5S0DYZ4Wt350KHQ4Yjf/Vj
         hCiTDDDy/pHJl5zCKTRP0uBuiCdZ5rSrrpwh4RHs4hIGq/7ltGupUA1e4CfgWR34duct
         nhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557965; x=1775162765;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLoJB0eAAHhKa/CHXdOXvJXrrrhW0QZ8tP3OfHcCcRU=;
        b=OWct3o1epyGs+UeHuewxmfVRzREnUGqBXcj74sPxv3FctZbFAlUif86lKjlv5kcewp
         k0EiHAigNaBzuN4UxApsyFmAHRakWuVqvAG1clySj2JrepqCMxskrm2dhkzk5tj9HoEb
         PSJr45Hku6pUh/GTEydMQaC3d7izfbrJHbc98PtCcz/HL954qwiYfD0U23cvk/29fOcg
         aoAvjDcWbX7ba1wmVsFJePftbRl+oWRT+tdSttmC4uFisZmLmS8dUMxAiso4FDtd+tFs
         UuXpfPcStGHEbKHFxmhgqe8rSSMd5KKjGYf28Rw9Wp6Unv0noe/1xGedo4igGL7smc5h
         3eNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5mYwkssCtsHH9S0gexWS9gwuJVN19JL2msxFQOfFOfc1wMLFTa7i+QPXW34Y1jWznbyRZ3ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXI11PwfPoEBH2NHJSaFovM9yNjl9RzA0JKZkziMjfgDQchYKm
	izwKYzhBMk7j7XfLiiSnZ6ap8iamTEggejiQvEcIpRl7XwdY4r5w1R0n
X-Gm-Gg: ATEYQzzh8eynkAfoV18omLPLDN0CMc8TMN5pX5+jlLjNiczvZ6OKG+D30dpaoNPRaEu
	32vV41VEkypLf/ix2FfmbtkWCIsGXpcwRAJEsOMh9Yo/Q0ez8UTYSP85WRtlpGrTAX3soFgpPLR
	DcJW6Ji36FfclgpdGjTVxqYYt9Vzv0z53QzW2Mrw46taiinh+x9TK7E3SiosCUEamrpHNABWRla
	o8Ao7VJYC+ryxlYpFOPmElt/dfqJ3qncJLlQMrBInawJr/KDvK7CC0CjcqUqAsIlB+ePe7OC7Xz
	E9dESBdCAIZrwDFTRM3YfHGojRihVJVsyw3gdCvZ+njbD1pOhOKBRLypS4np3jxtEwwdqG0U6TE
	7wG7FH9PSD8mlj1zyOi4Pq3Wo98ar9rQkemuQsUs1rESG/pV9QpKh0SXej7xJKYkLl9YJABEHb+
	OFUKwQ5VUQbzOf1ldgdLU5YpPWB9N4pyysHAgOXQA/6gDsvPBqrBnCQoj4CBxNF4yuvEql18bJ0
	Ki6
X-Received: by 2002:a05:690c:16:b0:79b:d341:56ff with SMTP id 00721157ae682-79bd3415a66mr27921567b3.2.1774557965266;
        Thu, 26 Mar 2026 13:46:05 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79b10c64964sm18223897b3.7.2026.03.26.13.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:46:04 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:46:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Yiming Qian <yimingqian591@gmail.com>, 
 daniel.zahka@gmail.com
Message-ID: <willemdebruijn.kernel.5279c14a2134@gmail.com>
In-Reply-To: <20260326130459.7225ae28@kernel.org>
References: <20260324205107.318303-1-kuba@kernel.org>
 <willemdebruijn.kernel.39ac32125c0cc@gmail.com>
 <20260326130459.7225ae28@kernel.org>
Subject: Re: [PATCH net] net: psp: check for device unregister when creating
 assoc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272249-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9266F33B8DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> On Tue, 24 Mar 2026 18:40:00 -0400 Willem de Bruijn wrote:
> > > @@ -320,6 +320,11 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
> > >  	id = info->attrs[PSP_A_ASSOC_DEV_ID];
> > >  	if (psd) {
> > >  		mutex_lock(&psd->lock);
> > > +		if (!psp_dev_is_registered(psd)) {
> > > +			mutex_unlock(&psd->lock);
> > > +			err = -ENODEV;
> > > +			goto err_psd_put;
> > > +		}  
> > 
> > This ensures that psd is valid for this caller of psp_dev_get_for_sock
> > and psp_dev_tryget, which is its only one (for now).
> > 
> > But is it confusing that psd can be cleared out while a reference is
> > held? Is the assumption that psp_dev_unregister usually holds the last
> > reference and its psp_dev_put will complete the clean up by calling
> > psp_dev_free. If so, would it make sense to defer everything
> > to psp_dev_free?
> > 
> > This is a simpler changes and fixes the issue for the only caller, so
> > LGTM. Just curious.
> 
> Meaning we should add a dance around removal like netdev does?
> Sleep until all the references are gone?
> Subjectively I think it's ugly, and in netdev it didn't really
> prevent races. Dunno, definitely subjective.

Yeah, if any caller of psp_dev_unregister has to know that the device
is gone to proceed, it would require something like that. Okay, I see
that that is needlessly messy.

