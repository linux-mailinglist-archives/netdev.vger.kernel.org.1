Return-Path: <netdev+bounces-253209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7IuqFBqHdmmoRgEAu9opvQ
	(envelope-from <netdev+bounces-253209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:11:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D382774
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C3403004200
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A97130648C;
	Sun, 25 Jan 2026 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4vK+Zk9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4912FC00C
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769375510; cv=none; b=igNxQLUUJAnvg8KNOL3p5vsy5avpzlfGruptSMe424vNdo29IuUFxzxu0z+2oQ1Jn1i+vsCzaTaCc95mvQHM9VGkbcND03bxR/Y2JZvCnQv+Ig4OjjoB3iy2jfm8FsCL2fJAOF0y6xmCUuqklC3xJcF7B8vva3u4xDh6nes85wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769375510; c=relaxed/simple;
	bh=ZgfsZm1chr+4X8OMyejfbFbZFOt+pr1GKsJcPjPAA6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJtmEyn6gTOjq8Dm7NUTOtbYNiAayat8nZJ1O+2oXXub+Gzli4WY0O/0HliinFQ+zekQUcSGStqj/tIFC5NQVyF/7xMOBZCepjK4FlJGdRHy3/KUU6ooz/fC4jEc/HRRiKu/yNBFu3c/o+uOyobs0c04Dm2AItIjpemY7wx/HmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4vK+Zk9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so31633695e9.3
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 13:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769375507; x=1769980307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TFHzyqFVz57K+9K9c88DN9Hx3bVH1iup+I9LjYMQFvo=;
        b=C4vK+Zk9jyrK+6svByFdSNUyS4cQhr/5pdKyLgVaD8D8fOmlbdYxfbIdpKQeFcJiK4
         oouJJ1bepEfqry1k1sxE1+wRW2J9ewTlFkve9W8dAET2O3zEsmfvQ6+bvteqNQG+OUQ5
         betOppvV8mxZy3IkNuRfgZ9ei8w+W9Wm1ybbb7SeDRmGfZM9Oa9vb10usw0WYPKmHrID
         hhmiw++svLulX126ENtepcSMAfJvchJENdixvKemcofNVfBB57CG+GroUv1jHdTSdZWb
         aTo6/SxS9GSUFaJcR385R93JHSu7Eo+pvtyGTxfYAMziIt/pZ5sAqNc9ZlJ3ryPKJLVi
         aRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769375507; x=1769980307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFHzyqFVz57K+9K9c88DN9Hx3bVH1iup+I9LjYMQFvo=;
        b=AmGSPXpGy19ytYa9jRT+ygWtBL7SDnXuyI0kRS+HNxNCQgRCDIvytE+tsoL1mrh7QL
         bUPukVnBXHq43IzSa+4dEtlrTnl7zMGus3PdRONcJyWAoapgk5vEtF8FhA+Pl0NgQoxY
         87ZNEqQGbfYo5lSmO2Zp4OMCR2xUN3Jn46JdGPFsdglCfsILU4SNsku5xNYMXJa9YD2A
         E6PMOBr9IMIAkKIAStjEadf/CFcgwpJuaSsTA8Fj/U6vaBtqUdjWRi6xzEuyR4LwZk7p
         fZsbtFtudk4xWaPfDM+8xVo4lELYVqiNZaIkB9kYAEhiHZjUz5o9jPofeKJ3asAksKpQ
         y2tw==
X-Forwarded-Encrypted: i=1; AJvYcCX1DEs+61TkqjL5yy+f5jCkKl3AVP1yExTC/L/W81TQn26JlU1iCtJpnlJWpjsVQztCsR6CHSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgIds8kw0URL09QopJPa2tylahnc93t1nmWh5FTarXQ5oN6VB
	N8i3KHmBHKqivW/RZydUZmLauGynxpv/m5awncRm31L2NE4bTZHsoV2U
X-Gm-Gg: AZuq6aJdPXCcStdViGFEvHZtA3tdIYGDPY+2tSYaKfCuI+OazvFEWzLemaBHViZWFMO
	gwCt1tnui+Gm5/8u5cDzxG1XBoeRlEycCUKSZy7sPr3OT1IfB1HD0EqIoXQpzSFMBnqYija5b31
	r51zHhpfSXjVidCWR07GsJut1wUxFx8BEWDd9U6AXqXnTg3muZbi98niDhu45PIc1pviPj0kwtY
	DRJw79iihXd2DyzVGtH1c8sHCuqPfMglLQgHB2wri0E04VQewjAzCwyevL6+2ARuUiemAIknA5i
	xp8+k8NhX2umgQS2+NbqeQjpUlRsGRmuLkbAu9NUsJ3GtKiFxjkW1775MiV1nN/rYtoIps8mODT
	FQxBrQoe90sPO2UHOhFP4Ov7Fo7hSOQW19Lg2fcFUg+L7MMR86nZtCwKYRK5LM80qB31spe3Tlt
	Ntv0SfI323pQszGPZxQiOn1+FRTnfED1hwW4P28kioPCz/edclVivDUOMIRzggQei7kD73ONlo8
	DFhqKI5ctE=
X-Received: by 2002:a05:600c:468f:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-4805cd407d7mr42485965e9.3.1769375507317;
        Sun, 25 Jan 2026 13:11:47 -0800 (PST)
Received: from gandalf.schnuecks.de (p200300c14f3b7a009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f3b:7a00:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf385sm293385965e9.13.2026.01.25.13.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 13:11:46 -0800 (PST)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 384AB2F64B2E; Sun, 25 Jan 2026 22:11:46 +0100 (CET)
Date: Sun, 25 Jan 2026 22:11:46 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, c.ebner@proxmox.com
Subject: Re: [regression] [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
Message-ID: <aXaHEk_eRJyhYfyM@gandalf.schnuecks.de>
References: <20250711114006.480026-1-edumazet@google.com>
 <20250711114006.480026-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711114006.480026-8-edumazet@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,proxmox.com];
	TAGGED_FROM(0.00)[bounces-253209-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D2D382774
X-Rspamd-Action: no action

Hi,

I am seeing a regression in the Valkey test suite with kernels >=
6.17. A bisection points to 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf
checks"), but my impression is that this change mostly makes an
underlying issue surface earlier. Additionally, 9ca48d616e ("tcp: do
not accept packets beyond window") seems to make the problem even
worse.

Valkey test scenario:

Test client opens a connection and sends a few MB worth of Valkey
commands (one write per command). The client does not perform any
reads until all commands have been sent.

Valkey server accepts the connection, enables TCP_NODELAY, and uses
non-blocking I/O to read/write. It writes a response for each command
and buffers data internally when required.

The connection runs over the loopback interface with MTU 65536. In
most cases this connection ends up stuck. The system is otherwise idle
and has plenty of free memory.

I have a a small reproducer where the client continously sends
commands and never reads. The server sends 127 bytes after reading
data (works for any payload < 2^wscale. 127 fills the buffer
fastest).

Trigger warning: reproducer code generated using AI:
https://gist.github.com/gmbnomis/0b75b2b88f49dc33d6c38ac23120b1e3

Here is a run on 6.19.0-rc6 using virtme-ng (server on port 7000, wscale is 7):

    1   0.000000    127.0.0.1 → 127.0.0.1    TCP 74 37532 → 7000 [SYN] Seq=0 Win=65495 Len=0 MSS=65495 SACK_PERM TSval=4155167414 TSecr=0 WS=128
    2   0.000080    127.0.0.1 → 127.0.0.1    TCP 74 7000 → 37532 [SYN, ACK] Seq=0 Ack=1 Win=65483 Len=0 MSS=65495 SACK_PERM TSval=4155167415 TSecr=4155167414 WS=128

[...]

At this point the client is still advertising a large receive window
although we run out of receive buffer space. This happens because
window scaling is used and we must not shrink the window (see
https://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive-buffers-and-how-we-fixed-it/).
Before 9ca48d616e ("tcp: do not accept packets beyond window"), the
stack would accept significantly more (up to max rmem, on 6.16 this
happens after approx 5MB with standard rmem buffer settings):
 1510   0.021964    127.0.0.1 → 127.0.0.1    TCP 226 37532 → 7000 [PSH, ACK] Seq=152225 Ack=95505 Win=65536 Len=160 TSval=4155167436 TSecr=4155167436
 1511   0.021977    127.0.0.1 → 127.0.0.1    TCP 193 7000 → 37532 [PSH, ACK] Seq=95505 Ack=152385 Win=191104 Len=127 TSval=4155167436 TSecr=4155167436
 
Out of memory: drop packet #1511. Since e2142825c120 ("net: tcp: send
zero-window ACK when no memory") the adv. window is set to zero. Since
8c670bdfa58e ("tcp: correct handling of extreme memory squeeze") the
right edge of the window actually moves to the left (to 95505):
 1512   0.021987    127.0.0.1 → 127.0.0.1    TCP 226 [TCP ZeroWindow] 37532 → 7000 [PSH, ACK] Seq=152385 Ack=95505 Win=0 Len=160 TSval=4155167436 TSecr=4155167436
 1513   0.029462    127.0.0.1 → 127.0.0.1    TCP 65549 [TCP ZeroWindow] 37532 → 7000 [ACK] Seq=152545 Ack=95505 Win=0 Len=65483 TSval=4155167444 TSecr=4155167436
 
The server has already sent data up to 95632, and continues with that
Seq, but from the client’s point of view this is now beyond the
receive window:
 1514   0.029847    127.0.0.1 → 127.0.0.1    TCP 66 7000 → 37532 [ACK] Seq=95632 Ack=218028 Win=191104 Len=0 TSval=4155167444 TSecr=4155167436
 
Send an ack for the ack #1514 because it is considered outside of the window:
 1515   0.029856    127.0.0.1 → 127.0.0.1    TCP 66 [TCP ZeroWindow] 37532 → 7000 [ACK] Seq=218028 Ack=95505 Win=0 Len=0 TSval=4155167444 TSecr=4155167436
 1516   0.033116    127.0.0.1 → 127.0.0.1    TCP 42615 [TCP ZeroWindow] 37532 → 7000 [PSH, ACK] Seq=218028 Ack=95505 Win=0 Len=42549 TSval=4155167448 TSecr=4155167436
 1517   0.037074    127.0.0.1 → 127.0.0.1    TCP 65549 [TCP ZeroWindow] 37532 → 7000 [ACK] Seq=260577 Ack=95505 Win=0 Len=65483 TSval=4155167451 TSecr=4155167436
 1518   0.037093    127.0.0.1 → 127.0.0.1    TCP 66 7000 → 37532 [ACK] Seq=95632 Ack=326060 Win=218240 Len=0 TSval=4155167452 TSecr=4155167448
 
All acks since #1514 are dropped. Thus, we see a retransmission of #1512.
1519   0.229190    127.0.0.1 → 127.0.0.1    TCP 226 [TCP ZeroWindow] [TCP Spurious Retransmission] 37532 → 7000 [PSH, ACK] Seq=152385 Ack=95505 Win=0 Len=160 TSval=4155167644 TSecr=4155167436
 
The server retransmits its last unacked segment. Since 9ca48d616e
"tcp: do not accept packets beyond window", this segment is dropped as
it extends beyond the window. (Before, this packet passed the sequence
number check and the client sent a window of fresh data on each
retransmission attempt (and only then)).
 1520   0.229201    127.0.0.1 → 127.0.0.1    TCP 193 [TCP Retransmission] 7000 → 37532 [PSH, ACK] Seq=95505 Ack=326060 Win=240896 Len=127 TSval=4155167644 TSecr=4155167448
 1521   0.229206    127.0.0.1 → 127.0.0.1    TCP 78 [TCP Dup ACK 1518#1] 7000 → 37532 [ACK] Seq=95632 Ack=326060 Win=240896 Len=0 TSval=4155167644 TSecr=4155167448 SLE=152385 SRE=152545
 
The connection is effectively stuck: Neither acks nor retranmissions
from the server are even being looked at.

I tried reverting 8c670bdfa58e ("tcp: correct handling of extreme
memory squeeze") on top of 6.19‑rc6. Connection does not hang, but is
broken from a protocol perspective:

0.018805    127.0.0.1 → 127.0.0.1    TCP 226 [TCP ZeroWindow] 34358 → 7000 [PSH, ACK] Seq=151425 Ack=95505 Win=0 Len=160 TSval=602409183 TSecr=602409183
0.024775    127.0.0.1 → 127.0.0.1    TCP 65549 34358 → 7000 [ACK] Seq=151585 Ack=95505 Win=65536 Len=65483 TSval=602409189 TSecr=602409183
0.024800    127.0.0.1 → 127.0.0.1    TCP 193 7000 → 34358 [PSH, ACK] Seq=95632 Ack=217068 Win=97408 Len=127 TSval=602409189 TSecr=602409183

When setting "net.ipv4.tcp_shrink_window=1", packets that cause the
window to shrink (to zero) are accepted (instead of dropping them). 
This helps in this particular scenario, since there is only one
packet in flight.  However, when there are still packets in flight at
the moment the window is closed, those packets are beyond the window
once they arrive (which is correct), but all further packets
sent by the server are regarded as beyond the window as well.

I am not sure what to make out of all of this. It seems that we cannot
always avoid shrinking the receive window (if window scaling is used).
Do we need to track the maximum advertised right edge for
sequence number validation?

- Simon

-- 
Simon Baatz <gmbnomis@gmail.com>

