Return-Path: <netdev+bounces-262912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGh2KjsGpmlVJAAAu9opvQ
	(envelope-from <netdev+bounces-262912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 22:50:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0081E4258
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 22:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0976A30B5ABE
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652931E825;
	Mon,  2 Mar 2026 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EanXGSWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4EE2E414
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486124; cv=none; b=HVsLWqoNfh29M9eSxt6PyR/heueYYo1nczTPcuXZE2JBiHii4kzsV0NZxBQ348Cl92JCNcSm1lumnluFgk5mwK7jaNQVNLWH7qHoY0V1AgSDUCVnFiyVsPq/R440wmIyfqreJuFnJd+T8CVWhIJYlgqC4/6uZfbkw+doVFjYk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486124; c=relaxed/simple;
	bh=UNj+48hFjlZPtLvRSwOqOFwRzy9flBmLKSxsZOtGJFg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AetnBjFJ0vvTLzsXsAgQSUcXtsedP/tejLq/vfymyf1bNMo/HMY4h/v74XEHAeTEPWRCG7vr92ObYuGNeTMGAecK5Tuxqlvmrm56MMv8/zDGzhZp1KUXroS8jyowtQ6n11coIi+7RZveTOeiEVDwUruNexpwYQM+zNr8vymz0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EanXGSWs; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64acd19e1dfso4388389d50.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 13:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772486122; x=1773090922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPR7FgjfJoLBWd0cNWlZd9KMulo3EEeoeZO3RDpxqYc=;
        b=EanXGSWslYiY0Z8yubui3zqnVkaJcjgz8oSW6Bat3laGO45yXE0X8ydiphFhjp1FJg
         iErekwGR/JtLuFEFfiJvIjyGvnzM5DEj1DtkXmkoLqebQUMu6FOFuR6/JnjXjmqIG9MG
         KTmu+h7w8+E57p3JsRRBAP/s296WH6SadhdUVRc2oF84oYHEsGGZvEOKRHxTidf3eROW
         lUY9fw1KhMdH5eV2bQg8GtCbOE17boRAKL+5s+LbjC7J9Bn3DwW8bVW/ynOC221MXL/4
         JrVA4E0yCIBsoE8Ehb56naOKD+kUw44vns2dJqYQXIKcDyFHbLpu9iDB8S8DXTIekKG8
         kTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772486122; x=1773090922;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPR7FgjfJoLBWd0cNWlZd9KMulo3EEeoeZO3RDpxqYc=;
        b=RjjVhblZ/PvsQtvN7Gl2dB0O1p41QKMOp8SDExbr/WzAsOG8smGm6BOdSDEGuWO3d/
         AYr9+TqBca3paI/GajypF3ZUU26w2NeNSd5NQIJ5m2shZDTUJLcp/EYD3oRBMK6VUYUE
         bqBL4TlfbCuaXL9qiFqaeAp8MFdwkoj+eZi9BGJ8bABiDtBcpZlRrIUCTcSAA1MtJmcE
         2MdkWTo3HaVFSc7rDxbZIQTALxVaw8pT6a9oV2XXrRAgqYoW9DLPo7xjQcg86trBDlOC
         BD3MJkQT6/hDFmz/+fswoCjvNRGwAM6Kc+TUu66oHVmmEAbyfagKG949oT4zMsW4npxY
         tj0Q==
X-Gm-Message-State: AOJu0Yzd+Y/aubi0H49h93wZnRHt6506tOw0rz3MZtH9kSi8f8Y9C+pb
	H0ajm9n3VxT7KoH+/CIyWnlrcyt2lJSKLZpgl9ny0kjZgdYaTWLBH5/U
X-Gm-Gg: ATEYQzyfTNgp58hp4F6n4Q1CgMKgWAgQANY0aoSVLFy7ELIwssWk6QdMfy+S+3L/Xfy
	hgIFz0701HemUMtelr7gGKkjnm99BU0oRn4gyiTHNEtlcZMOhAuZE7lV5z0Ut23P2OWbIkwuW6u
	3uQkH9HTH9fZx6sLQRzz8fW/4k2IfUNkbzMFeZteihaqY9PK1zE3rEywcufY1qnLGZ2kPJSzOJ+
	tEUw+srtDghYDnDD6r1McbqcShf07fuJ9Rjqifa7X9+V45YOHf1Cb57DrKR9cX/d844vuHZ0BV4
	1Nb1CfhW/+y0zurVA1ThLpYhF57G64I/6e6QiYwOwDUfRNsdaqRj5M7EPF0U87h8u2QiScLi49+
	QmSc7PeLjpk+2pPpak+uF8IIzfsbxmR+V8AL22n450XqaBjhmpCUhEZonUUUhs3v9qd4O9HD0bW
	SwPvkEtctPPNxj6OGHKm5M3yIkRrrGOJ+HEP9J1mlPScWuvIUnyUa6GckcNuz2ep9burvxvBLHF
	hJ9Bv6KkA==
X-Received: by 2002:a05:690e:68e:b0:64a:df6e:16b8 with SMTP id 956f58d0204a3-64cc201e25emr9227927d50.4.1772486121945;
        Mon, 02 Mar 2026 13:15:21 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cb7627181sm6100451d50.14.2026.03.02.13.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:15:21 -0800 (PST)
Date: Mon, 02 Mar 2026 16:15:20 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 jayakrishnan.udayavarma@broadcom.com, 
 ajit.khaparde@broadcom.com, 
 kiran.kella@broadcom.com, 
 akhilesh.samineni@broadcom.com, 
 sachin.suman@broadcom.com
Message-ID: <willemdebruijn.kernel.270f71617ce0@gmail.com>
In-Reply-To: <20260302195352.1015990-2-akhilesh.samineni@broadcom.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
 <20260302195352.1015990-2-akhilesh.samineni@broadcom.com>
Subject: Re: [net-next 1/3] psp: Support resetting statistics on a device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6D0081E4258
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262912-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[broadcom.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Akhilesh Samineni wrote:
> Drivers may need to reset per-device PSP statistics to zero.

The series does not include rationale why this may be needed.

What makes PSP counters special in this regard?

> Add a reset-stats netlink command and a corresponding optional
> driver callback to support this.
> 
> Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
> Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>

