Return-Path: <netdev+bounces-86055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A781589D657
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 12:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BC428195E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE3B81204;
	Tue,  9 Apr 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1kuiak7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E97EEF6;
	Tue,  9 Apr 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657408; cv=none; b=I59A5R5P6gLdNWEuLsG4gFD3xsXkDJexLGTCE+6w0domp7i7k/5gNdCQaI0wHod23RkYdDuPmcxE+CUcv1v+jpquDyN6GE51O1saKTX6XaXM1Xtm9YjDfMAW6jrPYJOVO5WFElbCc7+LcoG777FihJBRZGY+ABoZ9+ejyaz5QtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657408; c=relaxed/simple;
	bh=za5Qe3T81KPoPvfYbaiKVVOcs3g03twc/hkiVAkW01s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWX9KfcvZCxus7FZoYsVrqhKszjM+UKBBMGjgKCnyxzxdkte4jbYUyCkcSlnwALqoxSYb+Kf4t3SiG2oUamaoqOySAYXz1JbvIF5KNwg4wdzfulfO6ot2VtCd6XKq6exeekNScdh7gsX0eeijpgvp0Y1u5vpu2VNBx8qGql7sN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1kuiak7; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a7d6bc81c6so3819576eaf.2;
        Tue, 09 Apr 2024 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657406; x=1713262206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8mruov800edUKD3s5DsSyAgW1ponzVgToF/35nN5w8E=;
        b=i1kuiak7TDyd/u7h8zUPK30O54wSn706GlQFD0SE0sb7+4vRA9HrLmBEvTq44SZK30
         QWHrs3frBmIRNwKdBCEzFjJCSJL/L1ItEaPVe//wY7v3EwFZiQFtlAB6/yqozuyIsgue
         +wOGw+L6Non27PcI0JmJgEfTv8ijDj1xCczbds0uhVZGe6FwY9rbibahDoCNGa/DAYS4
         rc6sZ8ooz90NKfIQ8u0uMnzXMZZ4RxGz+dcs1B62wubZqTMXuNuq+wfQVZEuZQ4EsVmw
         K9sLiIMbvE8vCxlNlPLQ5+a1tXtHxObzwa7FGPKjMbtUsip0ek1J7f5khCmMEw/P/56r
         jOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657406; x=1713262206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mruov800edUKD3s5DsSyAgW1ponzVgToF/35nN5w8E=;
        b=ghRJJ/Cu2lTakpGrgB/81BcvyWJRGzCaTdxj13H3m+1Lj/wS1H5oNXCbp0jVEeE12b
         DGF4on73gYGy8mpYtdplOI5Wjvg+CLdoagHIYGZBvsad9onaqnPMcdvNVTDSiztsJXBs
         aMMKQ/5Gk+pXymHgQawp6Ywc3ZMkX/iaB80y7Q0nP638DCrpbaCvtLqaGzQlapbxEDdn
         tHe7Z5R1dzPRHJ9kVywQrRpdkhzf4J92g95vNf838V/yAqnrwaq9zzrzDaEYMkCPAuun
         ylCf8/AotpQdd2Ojytnf5ulNt6dVx4Eziu7bkgnyNCJSxY3tWUBxqg+BJ5PS0L+XlQlo
         2l8g==
X-Forwarded-Encrypted: i=1; AJvYcCW8KvVaQ8NzP0ZWoSUbdg9llENumb3rwMI3EM/5v4WIqBA4DyYGiK7O2rHSQ0UltXdwu1HnmENObWZpRYLJ0pd7ctwHyTT+ajyyNG4HsRNw53fAH2CVgh/2+36WX8xxXQXh846TshHSSSqx
X-Gm-Message-State: AOJu0YxUnWhxN0DEpXPpu2UW85oVmpcstnksG05lYNue6TPDqjIBnI9u
	zolRrDk/spr15iNBFzOn6NNg/F5MyFDm94tpVN/oIffIJ/7bKu4n
X-Google-Smtp-Source: AGHT+IEpEcoa0r0grFcu8YL7LH1ud285pJaTKCEQ6oxemBbkGixnvtKjoqeL6jo+fpNygSLBBDJY+g==
X-Received: by 2002:a05:6358:794:b0:186:160e:927a with SMTP id n20-20020a056358079400b00186160e927amr10112593rwj.25.1712657405870;
        Tue, 09 Apr 2024 03:10:05 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.26.66])
        by smtp.gmail.com with ESMTPSA id fn12-20020a056a002fcc00b006e5597994c8sm7959130pfb.5.2024.04.09.03.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:10:05 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/6] Implement reset reason mechanism to detect
Date: Tue,  9 Apr 2024 18:09:28 +0800
Message-Id: <20240409100934.37725-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In production, there are so many cases about why the RST skb is sent but
we don't have a very convenient/fast method to detect the exact underlying
reasons.

RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
and active kind (like tcp_send_active_reset()). The former can be traced
carefully 1) in TCP, with the help of drop reasons, which is based on
Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
RFC 8684. The latter is relatively independent, which should be
implemented on our own.

In this series, I focus on the fundamental implement mostly about how
the rstreason mechnism works and give the detailed passive part as an
example, not including the active reset part. In future, we can go
further and refine those NOT_SPECIFIED reasons.

Here are some examples when tracing:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NO_SOCKET

[1]
Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com/

v3
Link:
https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@gmail.com/
1. rebase (mptcp part) and address what Mat suggested.

v2
Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
1. rebase against the latest net-next tree

Jason Xing (6):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  rstreason: make it work in trace world

 include/net/request_sock.h |  3 +-
 include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |  2 +-
 include/trace/events/tcp.h | 37 +++++++++++++--
 net/dccp/ipv4.c            | 10 ++--
 net/dccp/ipv6.c            | 10 ++--
 net/dccp/minisocks.c       |  3 +-
 net/ipv4/tcp.c             | 15 ++++--
 net/ipv4/tcp_ipv4.c        | 14 +++---
 net/ipv4/tcp_minisocks.c   |  3 +-
 net/ipv4/tcp_output.c      |  4 +-
 net/ipv4/tcp_timer.c       |  9 ++--
 net/ipv6/tcp_ipv6.c        | 17 ++++---
 net/mptcp/protocol.c       |  4 +-
 net/mptcp/subflow.c        | 25 +++++++---
 15 files changed, 202 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3


