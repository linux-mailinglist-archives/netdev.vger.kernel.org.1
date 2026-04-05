Return-Path: <netdev+bounces-275436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEZZMLL40Wm9RwcAu9opvQ
	(envelope-from <netdev+bounces-275436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:52:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCEB39D71E
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73A74300B066
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 05:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC135369975;
	Sun,  5 Apr 2026 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO3bt2Km"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19D2C11E6
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775368367; cv=none; b=mJcbkd+3eoJdZegXGrWzbQQ4wEpJD2FhdP7J3Uq69sis9OhMM1kbKZEcWkB+ASqWIYJtwSofOYmEVuaX1Chw5b/s+d2BNAe3MtJuz213I84FgcDjd+4TVwkox5IeqHzi4raAVxvI/ZRJBCloxw8dpHDYh3hpEBf9ILQfXxT9aMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775368367; c=relaxed/simple;
	bh=NRU5uh4HR/YrGemNvGy4/heUBSk12o1mw92CBOBmcWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTh9tt0MGewkPxVbKTZW8uj+4mCDCFLFyUtikIf6h/unaa3dSlqt676YXXXlptBSidhB3wXpdh7VTJyYUw56OXZBHoqkfYSaWkYLAiounjD4gVL8knDj3bxT/YsEeXeOH3AMIlORvr2ZELZG4RUyl/7t91vB6e3O+rjrN/l++rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO3bt2Km; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48896199cbaso22836665e9.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775368365; x=1775973165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mu8MruZx2Msv4f1t170wsPDqDzFVNwj29jvR/Qu+G3M=;
        b=VO3bt2Kmkyxy6k2sZIarqjIjHERVHaAC0Ms1+3Cmb0R04ZhXAGm+gasYx6S9YNki4E
         +4hJ0EYmJ5c7GgGElwDZS8tGc50eS23dGyKFVa2Zlg9/3Tp1tYRy/3TkmAkZVXgT6D5W
         YmM/fO7fcnhVkwQq7AKZqAUvmDPUQD+z0IjObHi0Ml6r+mCWj5DrsBhQ2DpnPEYVzfpo
         04pi4AlcVh6dAc8q+9FaMa9kI/zkNILCLABQ9Yq9oXF+Rbshy3CkWrNz6BttbxKSUKqm
         ynhvMjzCwwz+oIkJAuSrjuHsbRzg3MO27OXvrrS5jjaXRZO0elKHzT4zVhRytHDhU1Cy
         yt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775368365; x=1775973165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu8MruZx2Msv4f1t170wsPDqDzFVNwj29jvR/Qu+G3M=;
        b=AQ6aXu6imGhDVbik/ONAnTtWHQlcQwgoGwDGAzExtthLHhzmJG1KnD2RnJBm0J+mB3
         IW9dIV/bVPhSL8nKEl9xiLLfacwuBl7iButkaZmnVkstraSu0hxokYk6pT0iozR5lpJ7
         F/YQ5mUlGbdbJOKLTv2VMu97BuOEvBrWvgCG49K3uc36cr5xQEn7IUIejXkM9pnHt3VF
         1CXZyPeKetdukJGi4uFVVgip94jMh29h6POs7XlkVeyUC7fFuhzkbplEo5Yg/dHbK4ay
         ZBCI6rCR3JWlGgDSf2bB/imvdmog3PrRShAtoLgU841f5+mxmjGHpOc7Jdt2Z6e1fXoY
         LO8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsujg3WuXcZ2JRBUJgYmImhdRcTPf9KlsaGwEqcjasfL6dPMSp2NcLfR8CrL85pHS9nSSi0gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsvIAXa8OflykBpqhg2YgrLAN4bs/fzmolJGgek9EPwo4kSGqJ
	DIBHaRhYfgAgHuSVr7JaKW+5o1RcEh5xrZNS1K+9fc6HsbxKIrNlWWtT
X-Gm-Gg: AeBDiev6DhTygV+hLjNRSfT3PceLnu1KPVgx76/RYkjTZggjywze5vZSb5DxvOco1fV
	J4flu0ym/X0gYt7sN8+gnyiWGtudKf9yiowfF8EOhGcPdO2xrC1Ox50x9ZwTcUpqaFdB96WP4PW
	5oiPSXk3yqV0v8cMZ+DbFpb+WDjcgeY8R0kbH0ahT4bLTxjCrpF1cH/NBfGT80vWbjkFGg3sjyD
	THsP3Qb3u3Xmc8QuFlqv2E6JGLTzUNo9MXzKWE0Ewypx4bm4Unc7mYhR3qTkciKBOpVQV5M5286
	DeAvZe/UOBQ1o57TmFG6YRl7gHLDlLfwiBu4Kk/uQ5DHJ3y0jD+DKGZVce1/Yxg+EEqI7f8YiQN
	fGuETpKakjADiI/GxdGV//FGI6BQEE/wXnlFwlr3caosvoeI+LeoNuIpGF/9L1uZrPh2qV11Yct
	vqz7crcxI5mApCUFNcZb+I65YI6HNtMKc3rRZPqWYFbuWfEMYrrB6pczYQfTVKVgpIw8G0ozg3D
	PC5q36121zB
X-Received: by 2002:a05:600c:3105:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-4889975f7ccmr120918525e9.13.1775368364789;
        Sat, 04 Apr 2026 22:52:44 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899e960a7sm55847465e9.27.2026.04.04.22.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 22:52:44 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v3 0/3] net: lan966x: fix page_pool error handling and error paths
Date: Sun,  5 Apr 2026 06:52:38 +0100
Message-ID: <20260405055241.35767-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275436-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CCEB39D71E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes error handling around the lan966x page pool:                                                                                                        
                                                                                                                                                                        
    1/3 adds the missing IS_ERR check after page_pool_create(), preventing                                                                                              
        a kernel oops when the error pointer flows into     
        xdp_rxq_info_reg_mem_model().                                                                                                                                   
                                                                                                                                                                        
    2/3 plugs page pool leaks in the lan966x_fdma_rx_alloc() and                                                                                                        
        lan966x_fdma_init() error paths, now reachable after 1/3.                                                                                                       
                                                                                                                                                                        
    3/3 fixes a use-after-free and page pool leak in the    
        lan966x_fdma_reload() restore path, where the hardware could                                                                                                    
        resume DMA into pages already returned to the page pool.

David Carlier (3):
  net: lan966x: fix page_pool error handling in
    lan966x_fdma_rx_alloc_page_pool()
  net: lan966x: fix page pool leak in error paths
  net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()

 .../ethernet/microchip/lan966x/lan966x_fdma.c | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

-- 
v2 -> v3:                                                                                                                                                             
    - 1/3: remove blank line between page_pool_create() and IS_ERR check (Jakub)
    - 2/3: drop rx->page_pool = NULL for consistency with lan966x_fdma_init()                                                                                           
           cleanup; update commit message accordingly (Jakub)                                                                                                           
    - 3/3: remove blank line between kmemdup() and !old_pages check (Jakub)                                                                                             
  v1 -> v2: address caller error paths raised by Jakub's review; add patches                                                                                            
           2/3 and 3/3                                                                                                                                                  
  v1: https://lore.kernel.org/netdev/20260402172823.83467-1-devnexen@gmail.com                                                                           
  v2: https://lore.kernel.org/netdev/20260403230714.10667-1-devnexen@gmail.com
2.53.0


