Return-Path: <netdev+bounces-237347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F5C4943A
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1B93A6811
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 20:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265462F0C7A;
	Mon, 10 Nov 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FUtY4Y11"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE212EB5CE
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807093; cv=none; b=EqR/lCdeCx8TZcpyDFv8JUMs1xy2HnP/E8VI8m9sjKkIVU+3CvolHA5LcbO3c0KXizxjym09X1YSyZbU1AfIzLyo+8E3cM7a+inUd99spf5FUvnbNC1AoCQy2kd+D6JJNrtL8JvHU0heMb9CFBQ7MXG3eQhy8Ara23DYL5tERQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807093; c=relaxed/simple;
	bh=3Ak2th6HK2dshHGZFNlkjRZYFwb3ZcIEd223LjkuYyk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=a/8oIEMiekUSOx8TkMdf6PR6wj3oJDsr3QWDe7jof19erGrEFWFUcTKVlC0KyabVn/PLrEm7wzturcGSOwkWsOVizOPGP7qLuk6jzQbaJMIeFhZEZmSjzwyp0X0YRZKX0SQUpPZxMKtQdu+VKEza4BNBTxDyNEgmnbCgdAobHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FUtY4Y11; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso2094626a91.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762807090; x=1763411890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBn4xCrT4JF+dfeNYWDS5elzZrDcTBGlNYcERXvV3og=;
        b=FUtY4Y11wSbIkiP82oImHLcCOtzmcBc6ks8dvH7mRQJXXmsDjD1343kan4bSjI7Zd3
         YyHF6wKFABMbxu1sKkEYNNrdXBAnIuqd2LlbW+TJEenjrT6jxOAGsu6qrAaOc6buRgVR
         mR+kl7w8lC/NV9NJZKxOM3S+zR59smqFYuj4ZB1QVyb0Jh3Qp9q0mqkWXKhUep48PNMj
         B8wy8k4zt3df6pwrE0bGg2XIHB2HlsYbGyacv1OuFbJhMr6LRAw601oHf6u+Zn2YXAcP
         RPmSbhOnrUgWY3PLZ2fs0Da+ZmCC1VPfMt6Sw1f5uZpZpZCvMJQqBW9+s/S6tQfyx68+
         xIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807090; x=1763411890;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBn4xCrT4JF+dfeNYWDS5elzZrDcTBGlNYcERXvV3og=;
        b=SESvM8cw0Ychh3QwQ+gzYrL+IC1yN9f0ix5Q/25zV4QlSE7vH8KuMMuaUv251+HTeP
         xm6bPnBL1l19QADo9g9BPBWtXRnzWMj9AS/homdllZxIgZpZkHfJo3lFPPlXt1ktGOoj
         OILm693ysYwEZyJMqfPvcmgdZjguZ9mvCN0/lauWLkpurLBeOv56IUdxKusSOuOg82BT
         xs0yA1fAsBLeME2/NUTYdasgqslLtftxYHtjVbq9iJIXXvIjnwvenuguKVnDek6ZITak
         b1LL+2q+pBte1Fzai0AH7zOu99gzarDDdqbzTB69uXUPPsVrPJ9uWz5FRRyEo/nF6TAa
         fkxg==
X-Gm-Message-State: AOJu0YxCyP1AZItfyIAgBKCGRhL9R4RgjzhqT79g80k7yAGeXqYTKtPz
	lSK4jVnUKBpYktyKVKdhH1of+PgzIgfrVaL0T2jbM9Q7+djWF3V43ui73O1Vz/uxBlfIX9oM+KG
	pjRer
X-Gm-Gg: ASbGncvxqxOWXN7ddOQFYT3b5lAv9iNmpyV0G6oYQx6LOnuFn8csHLCb02CgyLmXpTg
	41e1V0zXnceqm064YxVjBz05sLN3zsZmh+7dGNst5FAUwZp2hp1A5zInQ9gnVhDOxyrYBIB7Hji
	/zI0+zV6irY96ZpyXykaK16mcL/A4fOhqr0Ezpa5k7PVrs1dKh7n8XAwD+6PIe/Nn7x5/Tc3J1M
	hT01l3G8eTHw1vQtp+8OvuaPVlTYro9YnDUU8yxeRFzG6YTdv4NEBemqJ+9MEUHdAeHtoohv17x
	y5GZVT/X+g8EMt7Q8WQXuybzJ0MmJX0GbkPdN9AOl3X9qe2nTNMXFUYxOsxkDkC0yQqCep7ABYe
	P7V3ZElDJUWJ5TEs9T4cd7AJu80RPdK+Ixn2RzC1clR2t6QVLGoigEbRjejVBz2JyKQVyl6I3qH
	kVFFZWjBThVANiRZ7EZ5JMxTkO+snXxOe+lv9HSEvOoaDC
X-Google-Smtp-Source: AGHT+IGw2du7YIrJUmmwnRLyxTrlx+gO66o66i1nxUZBJAHD0g6nc/9xH93ROGdGWVMN+gro7i+v9Q==
X-Received: by 2002:a17:90b:2709:b0:340:be4d:8980 with SMTP id 98e67ed59e1d1-3436cb89ab8mr10466668a91.14.1762807089916;
        Mon, 10 Nov 2025 12:38:09 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba900fa571esm13384755a12.26.2025.11.10.12.38.09
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:38:09 -0800 (PST)
Date: Mon, 10 Nov 2025 12:38:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 220774] New: netem is broken in 6.18
Message-ID: <20251110123807.07ff5d89@phoenix>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Regression caused by:

commit ec8e0e3d7adef940cdf9475e2352c0680189d14e
Author: William Liu <will@willsroot.io>
Date:   Tue Jul 8 16:43:26 2025 +0000

    net/sched: Restrict conditions for adding duplicating netems to qdisc tree
    
    netem_enqueue's duplication prevention logic breaks when a netem
    resides in a qdisc tree with other netems - this can lead to a
    soft lockup and OOM loop in netem_dequeue, as seen in [1].
    Ensure that a duplicating netem cannot exist in a tree with other
    netems.
    
    Previous approaches suggested in discussions in chronological order:
    
    1) Track duplication status or ttl in the sk_buff struct. Considered
    too specific a use case to extend such a struct, though this would
    be a resilient fix and address other previous and potential future
    DOS bugs like the one described in loopy fun [2].
    
    2) Restrict netem_enqueue recursion depth like in act_mirred with a
    per cpu variable. However, netem_dequeue can call enqueue on its
    child, and the depth restriction could be bypassed if the child is a
    netem.
    
    3) Use the same approach as in 2, but add metadata in netem_skb_cb
    to handle the netem_dequeue case and track a packet's involvement
    in duplication. This is an overly complex approach, and Jamal
    notes that the skb cb can be overwritten to circumvent this
    safeguard.
    
    4) Prevent the addition of a netem to a qdisc tree if its ancestral
    path contains a netem. However, filters and actions can cause a
    packet to change paths when re-enqueued to the root from netem
    duplication, leading us to the current solution: prevent a
    duplicating netem from inhabiting the same tree as other netems.
    
    [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/
    [2] https://lwn.net/Articles/719297/
    
    Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
    Reported-by: William Liu <will@willsroot.io>
    Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
    Signed-off-by: William Liu <will@willsroot.io>
    Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
    Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
    Link: https://patch.msgid.link/20250708164141.875402-1-will@willsroot.io
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>


Begin forwarded message:

Date: Mon, 10 Nov 2025 19:13:57 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220774] New: netem is broken in 6.18


https://bugzilla.kernel.org/show_bug.cgi?id=220774

            Bug ID: 220774
           Summary: netem is broken in 6.18
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: jschung2@proton.me
        Regression: No

[jschung@localhost ~]$ cat test.sh 
#!/bin/bash

DEV="eth0"
NUM_QUEUES=32
DUPLICATE_PERCENT="5%"

tc qdisc del dev $DEV root > /dev/null 2>&1
tc qdisc add dev $DEV root handle 1: mq

for i in $(seq 1 $NUM_QUEUES); do
    HANDLE_ID=$((i * 10))
    PARENT_ID="1:$i"
    tc qdisc add dev $DEV parent $PARENT_ID handle ${HANDLE_ID}: netem
duplicate $DUPLICATE_PERCENT
done

[jschung@localhost ~]$ sudo ./test.sh 
[  2976.073299] netem: change failed
Error: netem: cannot mix duplicating netems with other netems in tree.

[jschung@localhost ~]$ uname -r
6.18.0-rc4

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

