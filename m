Return-Path: <netdev+bounces-182802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA9A89EEB
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11167188C0C9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6604229293D;
	Tue, 15 Apr 2025 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UGRPZt0K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96C2DFA4C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722262; cv=none; b=Owjari3wISVcPIfXWtmgPIIUNwfceL5TfKO2DJy/sAw9tyKpn6MP5eHMr2KPkYtHYYbCkCOpU4+ZlAFl+sYc4KCm/Jf/d7CKgpp8x4C1VhHe/Wp7lYAEuE6bf74AGRu5CrPikCgWg+k5sevhRHXLLD5NMs1PhTKedY6aJceq4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722262; c=relaxed/simple;
	bh=EEUcY8YZ2R0KUHtFZkhfJR9Jm2vCY5b54ax2Z5RKs4c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=occOcDKpkk+Vuca+O1C5/aS1BLydkhAAhTG6EtIPDwYIAkCP1IpTeW9QOUw4/+8Z+PiigcmTboN/B4rzlUMrkYIy7DaKFI4mE9NRXvfMdr7ggl5Ur9lmjZ5m9OndU5UlNnfpVAJjEMl4yMFz4daXDY6DUNSyBii8zhWKFOCT3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UGRPZt0K; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30beedb99c9so48524361fa.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744722257; x=1745327057; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BbaA3CQUwlcMAtRmW7ljN7YyCiyOTocNYeWyUSiLP14=;
        b=UGRPZt0Kb+BhNmjsWC33SvMETqAmRfFZWloGe/3OZah8HJebLs0wPgO95lq5yAF2jf
         k6P3wgP9UiP+lnKBEDYdN5PNZG2felwtk6CvsgZAC6R6SKZ2hDCr1FfLDm3jxVu++/Op
         cUKPumThFaQD57JQVISkip+JXA+F2KsUxZ2rZ+Cii/0ADHv0mz5LEJPUypb/0bFSsOJr
         jH+ramY6S4qBzC+RnKhRh9SyLkjZDG757BwEU+J9RUGfa0NYlMu/DhcDFZrwWV2ZHEFN
         yaiFwwXtW9C6VsHZrow0X2J/ReM/zCHDRQIqLP2k8am7EoBVmkHP0I0pgJAEuUoMvs/d
         aj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744722257; x=1745327057;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbaA3CQUwlcMAtRmW7ljN7YyCiyOTocNYeWyUSiLP14=;
        b=VgrNB7KGRnH8F2lKUiFAvINoEY29G2zZSMI0qkxkEp3KhGsQv3kolrwNjvno8B3f2L
         qSAyVSQ9AFmMadZC3gn52Q1kYzuHNz0AgCeqCYMSYylvtiL1RvNF+EraCVSA+AC9qrIw
         TtEor/qhFxqcEl9IChtyX0PRSSjMKmQTL3kERZwccfb9TxqYSai67PLdgeKa1ya7W1ec
         4fkMLwDz1as9x23uCYN7b6jxKY7kBw4k7yi1IBVu+dxbX2+AO+PXK2X5Z2mn+yWeRem9
         QYeAVurmSm/c6Z8g46FdthFw+naco2V4AqrYuKUUuic6mbeJgaxC928AdRetW8Mo9ZsI
         OjXw==
X-Gm-Message-State: AOJu0YxnuVQGDU0l6BGZdq7RXni3ZGHsTZnzxYZQbidAeaL/GjxCn0Og
	f+vKxuKH+yh4pegh2rjCjYrsmxA1OCyVUQL5my9nF6gORTx4Ykq22Ftd/MmqvYpUBDLid8vVsSD
	yqSWrQ1Wzwpha/oHChdaG+3qUmlwJoJttPu0lXUMOhpY1lgbIXgNpCg==
X-Gm-Gg: ASbGnctLrcNbPAx8tqNqvzkOYIut04F6QqZuMS11G1DCtTqD6Vl1b8PRc5dN2td7EE3
	Svhy+69PH/jL4AauaH+mqKM02S94mIe7PrA5VB/cbqXMBHguUQ9pEVCK17NmFYkFt7JzDpWmC3x
	nD/kmByj+dAQ3AaBwegwAUzzM=
X-Google-Smtp-Source: AGHT+IHp7+e8det4DAFFRceu4dX7AT9LGAM8anGacE9BXypUoh7pPUURmJJJ+Qlj1XyZ6+UBzDwMHKDMhXh3i1MaMBw=
X-Received: by 2002:a05:651c:1616:b0:307:deea:f576 with SMTP id
 38308e7fff4ca-31049aae540mr55955991fa.34.1744722255956; Tue, 15 Apr 2025
 06:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jacob Melander <jmelander@purestorage.com>
Date: Tue, 15 Apr 2025 15:04:04 +0200
X-Gm-Features: ATxdqUFrqONAsHCDgCEaZ6e2GJIApVgS4hf2qxPO-J_M3udlweEp6qGp11CqC8c
Message-ID: <CAP1cthn5mm3H7Gi46yNrvzRD-mbbjzQWLUFiBeKbzo6x27uUTg@mail.gmail.com>
Subject: [BUG] permanently hung TCP connection when using tcp_shrink_window
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I believe I have found a bug in the handling of tcp_shrink_window --
when the option is in use and it shrinks the window to a sequence
before wnd_sl1 (which can happen under packet reordering/loss where a
previous packet has updated window without being acked), this can
cause the connection to be permanently hung since it's impossible to
receive window updates.

I have narrowed down this issue by adding extra fields to tcp_probe.
These are shown in my excerpts below and correspond to their
respective fields in the tcp socket struct. The th_* fields added are
the corresponding fields from the tcp header that triggered the
tcp_probe.

My setup is a client and a server communicating with each other over
RPC/NFS (although the protocol should be entirely irrelevant). The
client is using a 4.18-based kernel with patches (although from
everything I can see the patches do not affect any of this code). The
server is using a 6.6.9-based kernel with patches (once again, the
patches should not affect any of this code). One thing worth
mentioning is that the server side application does not infinitely
receive - if the peer does not consume enough data then the
application stops receiving from the connection (in order to prevent
infinite memory usage). The server is also using keepalives on the
connection - these do not help resolving the hang/deadlock.

So let's walk through it, starting a few minutes into a quite busy
connection (~300 MB/s).

Packet 1 - stream is functioning normally but we have sent out
zero-window due to our buffer filling up (server application received
too slow most likely).
The incoming packet should be dealt with through SLOW_PATH since we
have sent out a zero-window.
The packet itself is a pure ACK - no data
tcp_validate_incoming -> tcp_sequence passes since th_seq == rcv_wup
and th_seq == rcv_nxt.
snd_wnd is updated accordingly to 35968 (th_window * scaling factor).

<idle>-0       [190] ..s8. 35789.976850: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=0 snd_nxt=0xa7288b3f snd_una=0xa727e7bf snd_cwnd=44
ssthresh=33 snd_wnd=41856 srtt=96 rcv_wnd=0 sock_cookie=31703
th_window=8992 th_seq=0x8dfe11af th_ack_seq=0xa7280ccb
rcv_nxt=0x8dfe11af rcv_wup=0x8dfe11af snd_wl1=0x8dfe11af


packet 2 - stream is still functioning and we are still in zero-window.
The incoming packet should be dealt with through SLOW_PATH since we
have sent out a zero-window.
The packet itself is a pure ACK - no data
tcp_validate_incoming -> tcp_sequence passes since th_seq == rcv_wup
and th_seq == rcv_nxt.
The only thing that has changed here compared to packet 1 is that the
client acked more data
snd_wnd is updated accordingly to 17664.

<idle>-0       [190] ..s8. 35789.976939: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=0 snd_nxt=0xa7288b3f snd_una=0xa7280ccb snd_cwnd=44
ssthresh=33 snd_wnd=35968 srtt=94 rcv_wnd=0 sock_cookie=31703
th_window=4416 th_seq=0x8dfe11af th_ack_seq=0xa7288b3f
rcv_nxt=0x8dfe11af rcv_wup=0x8dfe11af snd_wl1=0x8dfe11af


packet 3 - stream is still functioning and we are no longer in zero-window
The incoming packet should be dealt with through SLOW_PATH since
th_seq != rcv_nxt
tcp_validate_incoming -> tcp_sequence passes since th_seq > rcv_wup
and th_seq > (rcv_nxt + rcv_wnd (0x8e05792f)).
snd_wnd is updated accordingly to 0 (the peer is now advertising zero-window!).

<idle>-0       [190] ..s8. 35789.977019: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=3808 snd_nxt=0xa728d03f snd_una=0xa7288b3f
snd_cwnd=44 ssthresh=33 snd_wnd=17664 srtt=97 rcv_wnd=485248
sock_cookie=31703 th_window=0 th_seq=0x8dfe7a8b th_ack_seq=0xa728d03f
rcv_nxt=0x8dfe11af rcv_wup=0x8dfe11af snd_wl1=0x8dfe11af


packet 4 - stream is still functioning, peer is now in zero-window, we
are not in zero-window
The incoming packet should be dealt with through SLOW_PATH since
th_seq != rcv_nxt.
tcp_validate_incoming -> tcp_sequence passes since th_seq > rcv_wup
and th_seq > (rcv_nxt + rcv_wnd (0x8e0567af)).
window advertised by peer is still 0.
note that we have now revoked part of the window we previously
advertised - i.e. the last valid seq is now lower.

<idle>-0       [190] ..s8. 35789.977125: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=33824 snd_nxt=0xa728d03f snd_una=0xa728d03f
snd_cwnd=44 ssthresh=33 snd_wnd=0 srtt=95 rcv_wnd=480768
sock_cookie=31703 th_window=0 th_seq=0x8dfe896b th_ack_seq=0xa728d03f
rcv_nxt=0x8dfe11af rcv_wup=0x8dfe11af snd_wl1=0x8dfe7a8b

packet 5-8 - This is where the stream starts breaking down. We have
now entered zero-window (server side application stopped receiving
because the peer wasn't receiving responses most likely).
The connection stays this way for the rest of its lifetime.
The incoming packet should be dealt with through SLOW_PATH since we
have sent out a zero-window (and th_seq != rcv_nxt).
tcp_validate_incoming -> tcp_sequence now fails since th_seq > rcv_nxt
+ rcv_wnd (rcv_wnd is 0), this packet will be discarded.
window advertised by peer is still 0 (but we can't note this down
anyways since we discarded the packet).

<idle>-0       [190] ..s8. 35789.977127: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=42736 snd_nxt=0xa728d03f snd_una=0xa728d03f
snd_cwnd=44 ssthresh=33 snd_wnd=0 srtt=95 rcv_wnd=0 sock_cookie=31703
th_window=0 th_seq=0x8dff0d8b th_ack_seq=0xa728d03f rcv_nxt=0x8dfe11af
rcv_wup=0x8dfe11af snd_wl1=0x8dfe896b
<idle>-0       [190] ..s8. 35789.977139: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=37488 snd_nxt=0xa728d03f snd_una=0xa728d03f
snd_cwnd=44 ssthresh=33 snd_wnd=0 srtt=95 rcv_wnd=0 sock_cookie=31703
th_window=0 th_seq=0x8dffb47b th_ack_seq=0xa728d03f rcv_nxt=0x8dfe11af
rcv_wup=0x8dfe11af snd_wl1=0x8dfe896b
<idle>-0       [190] ..s8. 35789.977141: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=26928 snd_nxt=0xa728d03f snd_una=0xa728d03f
snd_cwnd=44 ssthresh=33 snd_wnd=0 srtt=95 rcv_wnd=0 sock_cookie=31703
th_window=0 th_seq=0x8e0046eb th_ack_seq=0xa728d03f rcv_nxt=0x8dfe11af
rcv_wup=0x8dfe11af snd_wl1=0x8dfe896b
<idle>-0       [190] ..s8. 35789.977149: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=37488 snd_nxt=0xa728d03f snd_una=0xa728d03f
snd_cwnd=44 ssthresh=33 snd_wnd=0 srtt=95 rcv_wnd=0 sock_cookie=31703
th_window=0 th_seq=0x8e00b01b th_ack_seq=0xa728d03f rcv_nxt=0x8dfe11af
rcv_wup=0x8dfe11af snd_wl1=0x8dfe896b


packet 9 - peer starts advertising a non-zero window (most likely
because the client application caught up and started reading the data
sent to it).
The incoming packet should be dealt with through SLOW_PATH since we
have sent out a zero-window (and th_seq != rcv_nxt).
As with previous 3 packets, we discard it since th_seq > rcv_nxt +
rcv_wnd (rcv_wnd is 0).
As such, we don't recognize that the window has opened up.

<idle>-0       [190] ..s8. 35789.977152: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=0 snd_nxt=0xa728d03f snd_una=0xa728d03f snd_cwnd=44
ssthresh=33 snd_wnd=0 srtt=95 rcv_wnd=0 sock_cookie=31703
th_window=5024 th_seq=0x8e01428b th_ack_seq=0xa728d03f
rcv_nxt=0x8dfe11af rcv_wup=0x8dfe11af snd_wl1=0x8dfe896b


packet 10 - peer now retries sending actual data (even though we are
telling it the window is 0). I'm not sure how legal this is from a TCP
standpoint - I assume we cannot actually rely on peers doing this?
The incoming packet should be dealt with through SLOW_PATH since we
have sent out a zero-window
This packet is actually not discarded for once - th_seq == rcv_next,
and it will go on to be processed as far as I can tell.
Assuming this packet gets to tcp_ack_update_window (I have not fully
analyzed the path in between - maybe it doesn't
even get there), then in tcp_ack_update_window we will call
tcp_may_update_window.

If you are looking at the source here - note the following definitions
for ack_seq and ack respectively (they correspond to th_seq and
th_ack_seq -- naming is hard):
    u32 ack_seq = TCP_SKB_CB(skb)->seq;
    u32 ack = TCP_SKB_CB(skb)->ack_seq;

ack == th_ack_seq == snd_una
ack_seq == th_seq < snd_wl1
As such, tcp_may_update_window will discard the update since no new
data is acked and the peer has previously sent a
zero-window in a later ack_seq.

And the actual data in the packet is discarded since we are in
zero-window and we have no room to store the data.

<idle>-0       [190] ..s8. 35789.977152: tcp_probe: family=AF_INET6
src=[::ffff:192.168.8.74]:2049 dest=[::ffff:192.168.8.4]:33960
mark=0x0 data_len=8948 snd_nxt=0xa728d03f snd_una=0xa728d03f
snd_cwnd=44 ssthresh=33 snd_wnd=0 srtt=95 rcv_wnd=0 sock_cookie=31703
th_window=5024 th_seq=0x8dfe11af th_ack_seq=0xa728d03f
rcv_nxt=0x8dfe11af rcv_wup=0x8dfe11af snd_wl1=0x8dfe896b


From here on out it's duplicates of the same pattern seen above. As
far as I can tell there is not any packet the peer could send us to
make us recognize it has opened up its window - either the packet seq
exceeds the valid window and gets discarded, or the packet seq comes
before snd_wl1 and is therefore not respected as a window update.

I did look through the code and tried to come up with some potential
fixes for the issue -- please have respect for me being a novice in
this area, so this may be mumbo jumbo, just thought it's hopefully at
least somewhat useful:
- Looking at the code, I wonder if ack seq could be used together with
seq for tracking the last window update, instead of merely relying on
seq. As I understand it - the reasoning behind snd_wl1 is to order
window updates with respect to each other - so that an earlier window
update is not received out of order with a later one causing an
unnecessarily pessimistic understanding of the window. In this regard
it should also hold true that a packet with an ack seq higher than a
previous packet is ordered strictly after that packet as sent from the
peer, right? Since I assume it is not legal to un-ack something which
has been acked. Assuming this, then perhaps the window could also be
updated when receiving a packet with an ack seq >= the latest ack seq?
Possibly also checking whether the new window is greater than the
previous one, so that only window increases are allowed using this
mechanism? Without updating packet discarding logic, I guess this does
rely on the peer doing a resend that exceeds the valid window though
(is that how all tcp peers behave)?
- Another idea would be that if it's possible to not early-discard
packets that are within the previously accepted window (before it was
shrunk), then it looks to me like the connection could eventually
recover via keepalive acks. This solution does feel unsatisfying
because there's still a stall of the connection until the keepalive
ack happens, but I think this would resolve the permanently hung
connection. I'm not sure how feasible it is though since it sounds
complicated to ensure all the paths can handle a packet which
should've been discarded in "normal conditions"?
- Yet another solution might be to never allow shrinking the window
past snd_wl1? I'm not sure about this one though because it relies on
the peer possibly resending data while we are advertising zero-window.
If it only does keepalive acks then those will also be outside of the
valid window and discarded - for this condition the peer would have to
send a packet at the magic seq of snd_wl1 to update the window (but at
least we won't discard the magic packet when the peer sends it).

Please let me know if any additional information is required.
I am able to test any patches as necessary, ideally mergeable on 6.6.9
if at all possible (that makes my life a lot easier). If not, I can
take a stab at merging them to 6.6.9 anyhow.

Thank you,
Jacob

