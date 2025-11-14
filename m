Return-Path: <netdev+bounces-238775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E5AC5F522
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C9D54E16AC
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABA8301468;
	Fri, 14 Nov 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSEbpf8h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985592FFF92
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154743; cv=none; b=nSqIzya5rADTd1XbC8RGanO1CPeaAEYFQKXMnqzS782C1PK2r/N5LPATxz6e0tai+6K0FqglijPxvj17N1jRDYua94slj/BpIClkWHYSZ8zmxbuOd2tJKutOlARx5kA511bCFjZtpC6x7BDBn6RSHiM2QNsT2wWHqZPRMUU5t2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154743; c=relaxed/simple;
	bh=HIzL03rZZAUOTidXvfl1eRZAhFxza8AIANmJTh/lei4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GOsa6AbtQ+hZnqeTOrLGcY4wyNM0XzctNDxmREGsqDxPvqdNixJXdC+nXOHqytGqSWCV1hJFvT0JJYwX9Xoe61MhfnXHR9hXHVpMX3uM9Pg/aWGijr2corBeI4n9ZdIEVjdWnfRYt/o5ydQsJFRoH2P5QhoOs3J8uypyOYZ00kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSEbpf8h; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3418ad76023so5619764a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763154742; x=1763759542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RhOb5eINxbYUfto3PJNXs+AkFfHyV62oHB08Gr6skkc=;
        b=XSEbpf8hiDCU+M3zEWxxkCxOhpAgSMlCxPiTiFSALuYyeLxgkNn+5eQFKxSEWGeCmV
         wGNk1SvYlUtdDAMAXblBw4hqz9pYuh49At3oSrzjeVNzMT+V8gt7/HDD9rycNCkUE4k9
         7M0RnphxgBT8pxTi7MY+QQ6SzxKk8YObM/adptGAfQ2cGySd2rEBPOvaY+zthhwkTwps
         AVsbbt8NQKAyjpBNhdDTKwrKJAnkJYYjGY1y5cyHXsyRsgep7+g/96W3qy4LHkeTe3s/
         BMbwm+HU9eXkVhbkRFBvGpBNdpfhsXBsXsxKvBzlyFC0fYaAXPRZx+EEYZmBP9XzlWhd
         fujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154742; x=1763759542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhOb5eINxbYUfto3PJNXs+AkFfHyV62oHB08Gr6skkc=;
        b=QYuj1H+1f1QPznaFqcxHLWuXzA36wOJb+EjabYFfP7UVRK4av1FBdY7LRgfXPNi8TO
         XVtQeNU+HK01R+Hd8/igerxoZMjHrOJR2tm0gF/7TxyfU2RiniVo3JvTkcr6iv1f9lKU
         ukqB9uOyW7vuMaiTj607zA2nW1KTmJ6NW9trmNROS8swMEr+TqMvBYxG6CoT/GZytFs/
         DB0oWAAxxO2SD506swpat9XkTbjhPORZM5b5nFFyabkZBSahjLFP2B1IqTcuaj3nXj34
         cQdLS07BSeohaLTvqYu4rBpbnet1Lo0hs/vj6LOJmBDEn+lVGU4h1uO5FPPYFYM7MHA4
         YKcw==
X-Gm-Message-State: AOJu0YwXg9Y+RGm0fp44+gJMnX7cevd/2EqcIPKF5caOeko43MVCoYR6
	MEKhMoybyxR/RSgS/0qBQC5ijvN3Sif/f09xGUkJ8AqQct7NXDsgAkhord+tLqbp/OyQ7Z0Me9u
	y7CLQYNjr/W//iWS5V2KD+/mZlWOPXpwSN64r8lAo/KtnbriiOSWbJYkX+acG5aPKEAFiNCRy8t
	FKtPufSOh5PNFV84SYAek/amhrr2GwY7TnXScgYVRkk113ygw=
X-Google-Smtp-Source: AGHT+IH2SZTUOOQ6vWGJjYH872jf1jo5IMY/q9mTGV8DDNjT8yCxuYhoSzRXceAHLxAryX5ra3tVnVDiQoEALw==
X-Received: from pjtp2.prod.google.com ([2002:a17:90a:c002:b0:33b:51fe:1a75])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b86:b0:33e:30b2:d20 with SMTP id 98e67ed59e1d1-343fa79011cmr5107680a91.33.1763154741676;
 Fri, 14 Nov 2025 13:12:21 -0800 (PST)
Date: Fri, 14 Nov 2025 13:11:42 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114211146.292068-1-joshwash@google.com>
Subject: [PATCH net-next 0/4] gve: Implement XDP HW RX Timestamping support
 for DQ
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, Kevin Yang <yyd@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

This patch series adds support for bpf_xdp_metadata_rx_timestamp from an
XDP program loaded into the driver on its own or bound to an XSK. This
is only supported for DQ.

Tim Hostetler (4):
  gve: Move ptp_schedule_worker to gve_init_clock
  gve: Wrap struct xdp_buff
  gve: Prepare bpf_xdp_metadata_rx_timestamp support
  gve: Add Rx HWTS metadata to AF_XDP ZC mode

-- 
2.51.2.1041.gc1ab5b90ca-goog


