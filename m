Return-Path: <netdev+bounces-260845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEhoEcTFnmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:49:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B57271954D2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21CB13015883
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC23038F241;
	Wed, 25 Feb 2026 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mvn8bl4V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoMl7KZN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04823AB88
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012613; cv=none; b=cV/F//G++xFSPDuSTrdpUMtDI9O6H93/m2v3mDstkRonAR6F9lB52XlJMlMlAgBuRPLvpLNc62rPLXPMO3Im03eblFZwTPvz3j1GLpb3wUPtwGDJQ/IkPR/dL8Xrn5SpVozgczuvRfZ3paNaFIY1W6fGKASBOBi2OrrgT7fE0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012613; c=relaxed/simple;
	bh=dJBC8mLDABEEc1VlJb5lfgoDrRuha1EpEiY4jlkAt8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GNhPwaS9mWnaBfy5nrlJdNzx3cIXPbMUKdVmBdMNh+APlLHy907T4zNOpm+5IXHxxGKLzfIkFEQD+yF8kk0KsizvHLsE46lpCcfiQTfEjZMfgMhLAsHb50nD8DJTbnkhzQ+Z4NcuYYLb/nmNApeFO8yqoFUXRStcWyBeXHG+mZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mvn8bl4V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoMl7KZN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772012611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJBC8mLDABEEc1VlJb5lfgoDrRuha1EpEiY4jlkAt8U=;
	b=Mvn8bl4VU4bXDD/sgHok6NZpQewQH63MALr+5PybB1pBTTneud4ClXCdFhKsE6OCNct60a
	ENb3Y5myCsPuOyu5XeT5G7pWK3gYyZst2z7us7Smi+0Qfozjydyd0lRmllLbZXy320tD2A
	LickXAq90OEc6FUWmOOOawSU5A5pG1M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-K4942J8kPqmoHwp341MN2Q-1; Wed, 25 Feb 2026 04:43:29 -0500
X-MC-Unique: K4942J8kPqmoHwp341MN2Q-1
X-Mimecast-MFC-AGG-ID: K4942J8kPqmoHwp341MN2Q_1772012608
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b9913c9so61786045e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772012608; x=1772617408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJBC8mLDABEEc1VlJb5lfgoDrRuha1EpEiY4jlkAt8U=;
        b=KoMl7KZNMKRGFlR55s5YCU5dmbxj0YLXiZqQ3iA6Za00ccoF6Hqcst/frmVGq2259D
         B0oEbu1rpqdWDzSljKSXfJ7fPvhN7oFzSZkigNlaqMU4qM0J86aUIcVHT/4bcx0+2rBd
         rith62M3/jHcLWm0ItZuggcwPGXmTFQtQoNrTZCCWsXedOC0RKbCSwnF3SZQhmdIqJfu
         3fW549yI8HrDgFnlpOVer8d7gVppOTOBs3WE3hmbbpZUZwhRC+wx5iTVYHlGpYp7o61b
         7dWuCcxQ+ZO5g+0ox2QFDRSZGe+0KRpTxycu0Hb370Sx6Tz6eOw+scMpPGWS3tZS8Ti7
         9c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012608; x=1772617408;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJBC8mLDABEEc1VlJb5lfgoDrRuha1EpEiY4jlkAt8U=;
        b=UVWuPtzP2AiPNtxqNOH+JX0xwZc+gdh946lQwS+e6eqtE2HM0XI3Ylvn54T7JAJmZK
         mNlM/jKdE36iZK19aL+4oite2FLsmLSGq60c2+8oljouUiytSpejvSiQ9+wlcm76B686
         Q/Uwc0q6j+zJ9ZtKE/Hvmar/Me6CGWqjW/9tPENIdroM3HPw9o2vbynN5wPQoDR2KGRj
         YgLACXTPCXlnLARIAbxC8aA+h3kwM1AWY8l8RjncABYEJtEzKEXVS9OjmFYebdYWiVd4
         i471CKHi9vPxNt9ubudmgiIR49PeXisdYDEBD0HBpDSlurpV1UPXvjbKNhkF1SQrJer/
         4qsg==
X-Forwarded-Encrypted: i=1; AJvYcCX0sKKE7FCglT3GjitBOdUcjY/xeuXyR9tSt1cqSVtP+4JcYtaTS3gDTFYXjfeTfnxTYjfyeGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXf1inmnHe3oc/FzOU5EFhXW2tbeCBs/OUVWfYfKQ4s6TGHGn
	1pDhr+QWj8n3hM8EQ+vPBAFWiymNPxlUCydsLI6ea0SHHK9ocyh2GclExRXk7R9iOofXBLR0J6j
	1Ze0r2vryUwSx8Z8RNZkCN/uSYshFp6y8W562lKkcAtcaRDFtzBYFugQKhQ==
X-Gm-Gg: ATEYQzxkzG/sfKiVRpB5RGPQ3xyI0CAPtA3a3G/c8XAHUMjLYFjpM12iFSxSa8OcbyY
	DiCin49Vwd76hmlQTD1tJJ9QF9k6b2gbEOHAhelUe+O2Looodl024LwfY6ROUsxHbVg/tJd5kfz
	cK9WHR8gfUkmwRok3CraCktiYz8tXPDskwUCrxHEHrB9L3w3Z2EFYEYNfJ9oScdfd+QyAAlDUs8
	2HDQcLHXdlSBf/lo8LVXqNA8Rw/GFb+T0Pd64Fv55ANRT8C+k+SttsXJp5teWNuL9DPFFuc3p8k
	y+Xc8O1c91uSKppg2K5ZHV/+w36Puhz+xGgwk2L/4pnDYMsXUzlRnbsnWp9L8p50vPfxxDTTYpv
	DNKXqEbnCNGQBZS+5gk+33Rvjt4m8ot5+0aUqbK+g6pZvX2uQ
X-Received: by 2002:a05:600c:8287:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-483a95eab99mr223255615e9.26.1772012608006;
        Wed, 25 Feb 2026 01:43:28 -0800 (PST)
X-Received: by 2002:a05:600c:8287:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-483a95eab99mr223255025e9.26.1772012607592;
        Wed, 25 Feb 2026 01:43:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb85c58sm8490385e9.9.2026.02.25.01.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:43:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7DC33516AE5; Wed, 25 Feb 2026 10:43:28 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, hawk@kernel.org,
 andrew+netdev@lunn.ch, david@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, ziy@nvidia.com,
 willy@infradead.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 asml.silence@gmail.com, axboe@kernel.dk, ncardwell@google.com,
 kuniyu@google.com, dsahern@kernel.org, almasrymina@google.com,
 sdf@fomichev.me, dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com,
 shivajikant@google.com, io-uring@vger.kernel.org
Subject: Re: [RESEND PATCH net-next] netmem: remove the pp fields from net_iov
In-Reply-To: <20260224061424.11219-1-byungchul@sk.com>
References: <20260224061424.11219-1-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 25 Feb 2026 10:43:28 +0100
Message-ID: <87fr6pma4f.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260845-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,skhynix.com,oracle.com,kernel.org,lunn.ch,suse.cz,nvidia.com,infradead.org,davemloft.net,google.com,redhat.com,gmail.com,kernel.dk,fomichev.me,davidwei.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sk.com:email,toke.dk:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B57271954D2
X-Rspamd-Action: no action

Byungchul Park <byungchul@sk.com> writes:

> Now that the pp fields in net_iov have no users, remove them from
> net_iov and clean up.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


