Return-Path: <netdev+bounces-267453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGSjCSYTtGlkgwAAu9opvQ
	(envelope-from <netdev+bounces-267453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:37:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255E28404E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D13D304D9A7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B039D6E9;
	Fri, 13 Mar 2026 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="Ec/UO7h4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5139DBE8
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408226; cv=none; b=qlwkqlW2Dv4WD1HzJnkyoYWA/c6LseGMLLGu5CR5Wp/Ri/RBG6/P7lw0r+eBDArOG2hPIRWIPV25HZ8iorerGz9f17mxRE0tg+SMMfGS9SoyWCSRvKw2hnO2ac6oYMRdXqGAwgIGRCfRzPMOJmoqbGZ42+chuKBkimZY4krWq9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408226; c=relaxed/simple;
	bh=EcEAR7cMwDtFqhxhdQDrdTczE4LmTtFe8qVXn+Aa2lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dz00UGrk8rtTOKWeVEM832Rpox7G95mAs4A/Yxy5G6qT6aG8GN8eoqc4lKwnLAckHr6yDRrn2nXcnfs8fFSvszkSCyWPs/MKcYDoQP2h6TWv0YkGFRTaUrkGRYHI781mV+Ci9VnTCso3Bj10f1qNntVqejFdgCpojaeoQQFr5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=Ec/UO7h4; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732e6a123so2770560c88.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1773408225; x=1774013025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QysejYucTpO+gpjK5YiHBGQ8tPcUtjODeWyyK1sWW1I=;
        b=Ec/UO7h4I/GsmPkYtCX5z+wTb/DN1ie1dezecZooMF6A/cFMW8XENF1/x5HEBSOkAY
         QWUemwpG5e8IseKgWNEWDtfFyAaGDtIbYKTO8NFEDyFhgtimYSyd48CrhnSTpUrWtDlA
         YLVAvpN0BU9nf5R3qAbGu06aMwhPWxe4kUd7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408225; x=1774013025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QysejYucTpO+gpjK5YiHBGQ8tPcUtjODeWyyK1sWW1I=;
        b=MJrCGxhQC+BktR1NDfqSoD1DP4pIriDeneDrzZhzKToxCIjICpH8LDa26w3C5w60ru
         Qd28MLeiTLfE+kSVQ6lWA4zzzVVVWGW2CIrh+0wSUVA66xEM5jELcoSErCvmdGLMr+oD
         LrLcwO0Cjrut3zug3p7JzgivFG7gH0vjZrlaBqa6soP9SlYSwpx+gNKvoHSZdbprcRtS
         CvIg1ZilJNtvLlKUjUBA6oL+soiSQuPrA9Mwn0oGwQqP+h7CzdSSnCIzPCL1/HrmBszr
         A0D816lgShX3wCJiZHFyrtDXGnYRKLggEv0KL54viWOCjzsULrIrQbN1/13JI/UDwu23
         xV0A==
X-Forwarded-Encrypted: i=1; AJvYcCUxrB3nL9qliC9vxVuRTNrOenlxQTYDLGg3O5lshBjNAlc35VJvHt2/U5vZ6TaTQv/HOUMS0es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYUx9/DKteMijUnE1UuT0G8BMgxE2GtVUjau24DLjoAXGpWXz
	XsX45KS+0eKLetFDYKXDPNBFLBx38WFS3OvQxBNOGPpxds+Ir+v3K4JxSLJSf6dF+L8=
X-Gm-Gg: ATEYQzyMQz+50rTy2NSquVSy3RGXCj7QdRR6R4UlhKVGyJVS7hh14RXVvQojxbDQAPz
	QvzO4EscseiKa7aX5uU98hneEKHCTEdfy9EQenUbCfqS76gJ5jT//wgIGn08n3J+pr0juNqo6Wd
	hBOOg+Be8ztUUn4rlTVnNUuZI9io3KT1aBi4ghQMP7MtASqWR5N6i+VKWRfsAeS+1GS1vPiEaTy
	cJ4t3t3T/RR8zir0R9DKvXON9ny9n791+cNybtvySffxAaahyu9USOzMCA1RzUfc/azsTKQJv/+
	QwU9BWQBRgxRkResup03tMuIvIVCxulbHHhlfK4CReoTGlNprkoZ9mQiY2HwBpE+SJVQ7l3gTIE
	wD3hUYOs8wcuXKGJ0skBO2EEVIVY7APiZHemnSaqb/GbILaVzlQViQ4Jsn77jrHpXBBzSMbg8f9
	DIvlT8MxuqIUrlDZz2LIbe3J7TvPs=
X-Received: by 2002:a05:7022:1a85:b0:123:348d:8576 with SMTP id a92af1059eb24-128f3d0dc31mr1713602c88.6.1773408224546;
        Fri, 13 Mar 2026 06:23:44 -0700 (PDT)
Received: from fedora ([179.105.152.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm1846358c88.9.2026.03.13.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:23:43 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: dhowells@redhat.com
Cc: marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH 0/2] rxrpc: Fix key and keyring reference count leaks
Date: Fri, 13 Mar 2026 10:23:25 -0300
Message-ID: <20260313132327.409785-1-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267453-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,allelesecurity.com:dkim,allelesecurity.com:mid]
X-Rspamd-Queue-Id: 2255E28404E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

While auditing the RxRPC protocol, I identified two separate reference count leaks related to security keys and keyrings.

The first leak occurs during client call allocation if security initialization fails. The second occurs in the setsockopt path due to an incorrect struct member check, allowing multiple keyring assignments to the same socket. Both issues prevent the cleanup of key/keyring objects, as evidenced by /proc/keys remaining populated after the user processes exit.

This series fixes both issues by ensuring key_put() is called on the error path in the call allocator and by correcting the logic in rxrpc_setsockopt().

Patch Summary:

rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()

Prevents multiple keyring assignments to a single socket by checking rx->securities instead of rx->key.

rxrpc: Fix key reference count leak in rxrpc_alloc_client_call()

Releases the key reference if rxrpc_init_client_call_security() fails.

Testing was performed by monitoring /proc/keys and using a reproducer that triggers failed security initialization and repeated setsockopt calls.

Anderson Nascimento (2):
  rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()
  rxrpc: Fix key reference count leak in rxrpc_alloc_client_call()

 net/rxrpc/af_rxrpc.c    | 2 +-
 net/rxrpc/call_object.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.53.0


