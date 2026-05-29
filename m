Return-Path: <netdev+bounces-293266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJilLNP6GWrB0QgAu9opvQ
	(envelope-from <netdev+bounces-293266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:45:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063DA608A72
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 871983016513
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEF242188B;
	Fri, 29 May 2026 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIBW9C+B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8D423141
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087504; cv=pass; b=RVFXk15+tYbqAXdW0nv6JdcylvQgtm64ivj4VOdqXS2RfcOhFEWbYYa3Ja+kX8TKctAr89JBFrqqBFBWI/aE0wUGLDK5PcyQUEpMWDc/b8lF9vTmh8g5EDEbCY3Ejir6Uqc0SXaDTzmgqoUaGlHdfxbcuQkPUYuUGMyhnyVTNn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087504; c=relaxed/simple;
	bh=Gx+GhAsuT02KdMZb9l2LS8mGn7N464qfzfBglCaka/4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SXP580aR3Bp+A26BhUy9vuN5qmR9j+7dL3Mm4rCLx4ioZnMP1a6kX2XGvC9Bxq0b4jw1sy5+wwHdWqsiBa8xwtj1zWPMvttYDr9Zyu/MFy5tGcSvD2KPxWx6S1reIl+tQmyj6KwTCrTr0HDm81CYlwVDg8WaPffIFQUS+o8pMW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIBW9C+B; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so6527112f8f.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780087500; cv=none;
        d=google.com; s=arc-20240605;
        b=ZAAHsFiNIcKZ+28vMHVC5anAbODQDxr1i3gqPc7IOkdNwkZbmWkaJapLWBHK4/u4Fe
         jG1jPobYiP/EefNdh1r8uZs8Z9zCNPEs9EFFlqhfAopUF//1K7zxtexcG5FH440q6NKH
         4tTXtVRyzAimb5XbKXIwzmcSHYeIUai8ke87V9tqy57hGScVEGnaT45QDtfDGF9dX8pm
         cSeKWFultZhDxdBiGxT9FV1nL1R3PX53oRq+7+42jYqjgNNT34qEo7uFW6WzKLI2qbC+
         13oo4PrwzHzGY6e8AbNcWxPKy5edITaKYI//wyPcvYear/VA5vf7EO5Ti9B763/HsHGU
         rqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Gx+GhAsuT02KdMZb9l2LS8mGn7N464qfzfBglCaka/4=;
        fh=olSIGIBxvLGQFx9kpUDY2aTqH2R7gfrr/g6wQ/4zUF0=;
        b=FWh/ouxZjMJCuBVoerdbtpFlkpx11bIxg5qE4kZ2R9k0yhSVQm95jPiNfPNKpupT9h
         +UhanbGDIfxPIQ5bBE2HcfieabhEsOTTu2zVEpA3Qlv2r8h4do2Uv/pYzofPgPpcmjhR
         XfhJBzho8BJ8APatMo6pyB7tSvx9IWBEwOT1/FgCQzvI99efwFl1fWJvSYZGa5NnR8Xu
         xIAoQMg7NjnPet+Xp+9XBnkKdwufwNbyI4PiW2jM641aZzvXPW2MV7l1G+uUKQ6PBC4i
         sTMc+LsKbOIRKP+xZtuPmhXL4T1ClyVXDHCEC4+505DMPjUEx07AH08KO7MKbBeUfKm6
         njJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780087500; x=1780692300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gx+GhAsuT02KdMZb9l2LS8mGn7N464qfzfBglCaka/4=;
        b=BIBW9C+B6kuU1XvX4bM0x4VtRUFeZO8TBrQ5UK7EhLsVVMjXbGMKM2zaj0o1vtn+Ha
         rwturKsX2F+5hEcwWzIWCOjW/qC1aD4FFdfzEWRnUVrLE0FWLV6GDh6UN82XQ6MyX5OZ
         2wXELDpabniwtWKZMJqh86vBE0O7gL9a/bqCv3Dh9HzrUMHZKZXJ4hAJVxqUdXDmh3ux
         xUIy0pM9Gu1Fcmr21bni2o/YaXU24A6dMlnTK6IPQGBqtUoWriM8di5nilIWEHYrlSQq
         fYtJot/wIv+D0349HdLPnHLZ52ot21ybj3KdEvqS0diY7n0Rlmt7h/GTHtCV/yuOrtNb
         OJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087500; x=1780692300;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx+GhAsuT02KdMZb9l2LS8mGn7N464qfzfBglCaka/4=;
        b=DQbx1mpupJQH9FLTI5ZqBsDxFUGrrICDKPpMVHsshTM6bdf/+UhdbP/OQJJ7gwEUjt
         WKBwlV0Ix/T8RqWIOJCyeduduFEMNxS/YHNxPxkzdwNzmtTlCLdwsC4iYSDIT4kx7Ri2
         i26SNeZUPrFGOLB9bhaDAKbYJ1of4hWxWxJk2Ndj+xLUBFfRcHkHR0pyv9Izmxd2kzwU
         FJ89kducZujXiVuCO6rHAWwunXOyJ/eHmDAOyiNMJ0sO3Dyc6c55beU9Jp0iTPUBwOuV
         Xq4Bg9FcHi+2Q+g78bb9fSKECkSLN5CUleh3BKWDxPu9KK2QjWoRP5R0EJ6sI5Gb4THi
         IViw==
X-Gm-Message-State: AOJu0YwlYyIsJV6uPcPgSu8t12RgCzaFqMrUaUGd0wPCWRu11knM05D/
	S/rW24+0Hws3ouqqkXD8J7drfZ0ZdI1zsaylUlL9TP1jAL2LxyS/25umsIRcpd+1eSPX0w9H5h7
	dLt5ilH+mbnR5HzGn2z/RRjVhSV8wMSmRIICpQxe2WQyuedmu3oSospl3w+c=
X-Gm-Gg: Acq92OF2GkOH7nOHdvlXsHpfY2ve+8YNzAxAwKFil1mpgBB6fzxtgnOHjuAJnWaNc6o
	M0EWx/c3nYP31VT/qLLDj/lwyNWObXfaGC/mzpPhvFS3yu2PrGeOVUEUyYmeIzmHr5sTe/YOw/U
	vlLzKVS2yg7s9gxi5BLa6aI8DG/neRw7KbrrtpJw5g17X73cbW0pFp868APKIedLZxh8xHZKf2h
	CWwhWm0/Y+BCFlQN+S6cjvNJ8ZoEPTAomKYuzG0xh8LkohK/MT9iRlfNZaZ1t2/6kfvKRjhcCa4
	URIMAA7JW4WEhyVm
X-Received: by 2002:adf:e990:0:b0:45e:73a5:e5e4 with SMTP id
 ffacd0b85a97d-45ef6ba0b7dmr1585658f8f.33.1780087499794; Fri, 29 May 2026
 13:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sheena Mohan <sheenamo@google.com>
Date: Fri, 29 May 2026 13:44:48 -0700
X-Gm-Features: AVHnY4K5jWN7sWp1DFPZPVuaXW73MHwYIyvHWidGeUVyqBZuNFxuuJKfbjK4J6o
Message-ID: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
Subject: [ANN] Google's Netdev-CI for IDPF and GVE
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	Willem de Bruijn <willemb@google.com>, Max Yuan <maxyuan@google.com>, 
	Pin-yen Lin <treapking@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Joshua Washington <joshwash@google.com>, Danny Gonzalez <digonzal@google.com>, 
	David Decotigny <decot@google.com>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293266-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sheenamo@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 063DA608A72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi everyone,

We are happy to share that Netdev-CI testing on both IDPF (running on
Google Bare Metal) and GVE (running on Google Virtual Machines) is now
up and running.
This NIPA integration work enables executing kselftests against the
current proposed net-next kernel branch on real hardware.

Thanks to Danny, Max, and Pin-yen for their contributions!

The test results and logs are available in:

IDPF Results: https://idpf-netdev-nipa.static.usercontent.goog/json/results.json
GVE Results: https://gve-netdev-nipa.static.usercontent.goog/json/results.json

Thanks,
Sheena Mohan

