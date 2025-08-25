Return-Path: <netdev+bounces-216579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E173B349AB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1281785A2
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854732737E0;
	Mon, 25 Aug 2025 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="PxdtBdKb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f58.google.com (mail-lf1-f58.google.com [209.85.167.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351112C325C
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145020; cv=none; b=dZZYudE6o88UJIDEWEpg4z2ty+Wkj1c6raNr5JtwNCcteR9o/dVYW1toK/jQ2E5rgrexaxjaq3/wxTLIUeHn7W1XIBEqFRmACEmgXC0S734GoehW0AC30nufcqG1a9dknpV9OI1axEmcFIQdzqITjID1G/HmZhZEnZT/o8T3ldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145020; c=relaxed/simple;
	bh=NwBGp9ukfy73lDSkTzwNx2mkc0f+IWeud156NLu0d9Q=;
	h=Date:From:To:Cc:Message-Id:Subject:MIME-Version:Content-Type; b=ZIqsaIhEV/SVlusK8ENcyPVZwNGGrxnlgAllAhZ1RJcHGDnHX7lQTu8nz8NXitv+r24U+vPTMjuto5Ot7lOJD3BOaM9bkKR45C5w1z122H9tYrrR0+9MU2zo2YXnuaYpPFOfLiL4py61Iuuncb49rOksrpKwSvV+1zQTyG7Eo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=PxdtBdKb; arc=none smtp.client-ip=209.85.167.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-lf1-f58.google.com with SMTP id 2adb3069b0e04-55f3a2366f7so1633328e87.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756145015; x=1756749815; darn=vger.kernel.org;
        h=mime-version:subject:message-id:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QFoxt/jPmioX2MXqIAsXsgDiAPtpXxMMacv3dy/vP5w=;
        b=PxdtBdKbpABhDY/Idbdijc8ujduChGaBeJsbfitUPty278KzZdDhxtJTeBE3tndzCy
         Ui0HMYOk/HIk7ALAnKDPgPh69SRoIw1ZKh532uloA3HW3xIp+/C5Gll0U28iJ+o1Y4iM
         Eh9Kb4DxXW743cv7VZ4l5P+STzEjJ+MBoFxtaZaKjssRdK7c+dNLDU7hCJmd0ztADXbJ
         HnlPbtO8p1VrupDPJ6T3qBfyZYLm7YjdqcnFWxsOUweTgUJfOtJ6OUFYnW2LEUCoxz+h
         VEWnQev8T7uKNCK0oK17iYIPCB/fRgd5OQLgQLSPeAoMcbydLOcD2V1t7IXO2ARxxuji
         10wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145015; x=1756749815;
        h=mime-version:subject:message-id:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFoxt/jPmioX2MXqIAsXsgDiAPtpXxMMacv3dy/vP5w=;
        b=DLbXd2YzS9wOAoJ0oEv4f1ctOjmrepkEdUlqXaKYmcSTQNXdXXkaHzSvwHhm/xy8jI
         qahSXU3OrumKJHX2v6B+owtf+u7p+RxEp4j5TsPjkkcKhMSCKRN3jxqM9HCyWVx5ukfT
         Wc6EwOFiWX6PzfI8ZGOT6Mf/PW6u0ZYMaDLODvBVAvE91q4foAVudE5SgzDhRm5iRg0a
         2+eUHmqNjz4dIc8n4q9wGUsfAU+dNCQrzMOqiJwWJmfuGRekYQsykUHkPyFha1Zj9H5M
         H5FWX9KM3ebRHmBSLyT0y6npqcZVsqnvaWFrFze52IwCqy2Tl3k0HIDqFiphyi8h2t4y
         +2Mg==
X-Gm-Message-State: AOJu0Yw5J2ULBbwO64Yd2RXIdW9yeBuKfEHjpPMWSqgla1cYHlN3MsbJ
	B7ssbp4LHVE/FjFVUPpEyo2R9ZFShJaV4Yc+sy2W6v0tOMkznzagJiEQPPgzJ/6LUBIB4e0WxRW
	pkPzYdF93Kr0vSQ==
X-Google-Smtp-Source: AGHT+IE1Qmp/nDgt7Cii7raF361VAKDGh7TxS/A4J0n3oQeXfvdAv77Dakaznt2Nzl1e5/ATCYuRcEWoOg==
X-Received: by 2002:a05:6512:3e08:b0:55f:4407:558 with SMTP id 2adb3069b0e04-55f440707f9mr1834568e87.33.1756145015048;
        Mon, 25 Aug 2025 11:03:35 -0700 (PDT)
X-Google-Already-Archived: Yes
X-Google-Already-Archived-Group-Id: 38d67f2e3d
X-Google-Doc-Id: e15313c561668
X-Google-Thread-Id: ec15f2a7194813d2
X-Google-Message-Url: http://groups.google.com/a/aisle.com/group/disclosure/msg/e15313c561668
X-Google-Thread-Url: http://groups.google.com/a/aisle.com/group/disclosure/t/ec15f2a7194813d2
X-Google-Web-Client: true
Date: Mon, 25 Aug 2025 11:03:32 -0700 (PDT)
From: Disclosure <disclosure@aisle.com>
To: Disclosure <disclosure@aisle.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,  <security@kernel.org>
Message-Id: <819ff534-1351-46a1-98a3-069a6cdcc0f2n@aisle.com>
Subject: [PATCH net] netrom: validate header lengths in nr_rx_frame() using
 pskb_may_pull()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_20364_1528825248.1756145012131"

------=_Part_20364_1528825248.1756145012131
Content-Type: multipart/alternative; 
	boundary="----=_Part_20365_1406235946.1756145012131"

------=_Part_20365_1406235946.1756145012131
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From 0c03a83d9853b1d7f88a7399a8d08b35696f78a5 Mon Sep 17 00:00:00 2001
From: Stanislav Fort <disclosure@aisle.com>
Date: Mon, 25 Aug 2025 19:51:12 +0200
Subject: [PATCH] [PATCH net] netrom: validate header lengths in 
nr_rx_frame()
 using pskb_may_pull()

NET/ROM nr_rx_frame() dereferences the 5-byte transport header
unconditionally. nr_route_frame() currently accepts frames as short as
NR_NETWORK_LEN (15 bytes), which can lead to small out-of-bounds reads
on short frames.

Fix by using pskb_may_pull() in nr_rx_frame() to ensure the full
NET/ROM network + transport header is present before accessing it, and
guard the extra fields used by NR_CONNREQ (window, user address, and the
optional BPQ timeout extension) with additional pskb_may_pull() checks.

This aligns with recent fixes using pskb_may_pull() to validate header
availability.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Stanislav Fort <disclosure@aisle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 net/netrom/af_netrom.c | 12 +++++++++++-
 net/netrom/nr_route.c  |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 3331669d8e33..1fbaa161288a 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -885,6 +885,10 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device 
*dev)
   * skb->data points to the netrom frame start
   */
 
+ /* Ensure NET/ROM network + transport header are present */
+ if (!pskb_may_pull(skb, NR_NETWORK_LEN + NR_TRANSPORT_LEN))
+ return 0;
+
  src  = (ax25_address *)(skb->data + 0);
  dest = (ax25_address *)(skb->data + 7);
 
@@ -961,6 +965,12 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device 
*dev)
  return 0;
  }
 
+ /* Ensure NR_CONNREQ fields (window + user address) are present */
+ if (!pskb_may_pull(skb, 21 + AX25_ADDR_LEN)) {
+ nr_transmit_refusal(skb, 0);
+ return 0;
+ }
+
  sk = nr_find_listener(dest);
 
  user = (ax25_address *)(skb->data + 21);
@@ -1005,7 +1015,7 @@ int nr_rx_frame(struct sk_buff *skb, struct 
net_device *dev)
  nr_make->window = window;
 
  /* L4 timeout negotiation */
- if (skb->len == 37) {
+ if (skb->len == 37 && pskb_may_pull(skb, 37)) {
  timeout = skb->data[36] * 256 + skb->data[35];
  if (timeout * HZ < nr_make->t1)
  nr_make->t1 = timeout * HZ;
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index b94cb2ffbaf8..b4b0ee546799 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -758,7 +758,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
   * Reject malformed packets early. Check that it contains at least 2
   * addresses and 1 byte more for Time-To-Live
   */
- if (skb->len < 2 * sizeof(ax25_address) + 1)
+ if (skb->len < NR_NETWORK_LEN)
  return 0;
 
  nr_src  = (ax25_address *)(skb->data + 0);
-- 
2.39.3 (Apple Git-146)


------=_Part_20365_1406235946.1756145012131
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From 0c03a83d9853b1d7f88a7399a8d08b35696f78a5 Mon Sep 17 00:00:00 2001<br /=
>From: Stanislav Fort &lt;disclosure@aisle.com&gt;<br />Date: Mon, 25 Aug 2=
025 19:51:12 +0200<br />Subject: [PATCH] [PATCH net] netrom: validate heade=
r lengths in nr_rx_frame()<br />=C2=A0using pskb_may_pull()<br /><br />NET/=
ROM nr_rx_frame() dereferences the 5-byte transport header<br />uncondition=
ally. nr_route_frame() currently accepts frames as short as<br />NR_NETWORK=
_LEN (15 bytes), which can lead to small out-of-bounds reads<br />on short =
frames.<br /><br />Fix by using pskb_may_pull() in nr_rx_frame() to ensure =
the full<br />NET/ROM network + transport header is present before accessin=
g it, and<br />guard the extra fields used by NR_CONNREQ (window, user addr=
ess, and the<br />optional BPQ timeout extension) with additional pskb_may_=
pull() checks.<br /><br />This aligns with recent fixes using pskb_may_pull=
() to validate header<br />availability.<br /><br />Fixes: 1da177e4c3f4 ("L=
inux-2.6.12-rc2")<br />Reported-by: Stanislav Fort &lt;disclosure@aisle.com=
&gt;<br />Cc: stable@vger.kernel.org<br />Signed-off-by: Stanislav Fort &lt=
;disclosure@aisle.com&gt;<br />---<br />=C2=A0net/netrom/af_netrom.c | 12 +=
++++++++++-<br />=C2=A0net/netrom/nr_route.c =C2=A0| =C2=A02 +-<br />=C2=A0=
2 files changed, 12 insertions(+), 2 deletions(-)<br /><br />diff --git a/n=
et/netrom/af_netrom.c b/net/netrom/af_netrom.c<br />index 3331669d8e33..1fb=
aa161288a 100644<br />--- a/net/netrom/af_netrom.c<br />+++ b/net/netrom/af=
_netrom.c<br />@@ -885,6 +885,10 @@ int nr_rx_frame(struct sk_buff *skb, st=
ruct net_device *dev)<br />=C2=A0<span style=3D"white-space: pre;">=09</spa=
n>=C2=A0*<span style=3D"white-space: pre;">=09</span>skb-&gt;data points to=
 the netrom frame start<br />=C2=A0<span style=3D"white-space: pre;">=09</s=
pan>=C2=A0*/<br />=C2=A0<br />+<span style=3D"white-space: pre;">=09</span>=
/* Ensure NET/ROM network + transport header are present */<br />+<span sty=
le=3D"white-space: pre;">=09</span>if (!pskb_may_pull(skb, NR_NETWORK_LEN +=
 NR_TRANSPORT_LEN))<br />+<span style=3D"white-space: pre;">=09=09</span>re=
turn 0;<br />+<br />=C2=A0<span style=3D"white-space: pre;">=09</span>src =
=C2=A0=3D (ax25_address *)(skb-&gt;data + 0);<br />=C2=A0<span style=3D"whi=
te-space: pre;">=09</span>dest =3D (ax25_address *)(skb-&gt;data + 7);<br /=
>=C2=A0<br />@@ -961,6 +965,12 @@ int nr_rx_frame(struct sk_buff *skb, stru=
ct net_device *dev)<br />=C2=A0<span style=3D"white-space: pre;">=09=09</sp=
an>return 0;<br />=C2=A0<span style=3D"white-space: pre;">=09</span>}<br />=
=C2=A0<br />+<span style=3D"white-space: pre;">=09</span>/* Ensure NR_CONNR=
EQ fields (window + user address) are present */<br />+<span style=3D"white=
-space: pre;">=09</span>if (!pskb_may_pull(skb, 21 + AX25_ADDR_LEN)) {<br /=
>+<span style=3D"white-space: pre;">=09=09</span>nr_transmit_refusal(skb, 0=
);<br />+<span style=3D"white-space: pre;">=09=09</span>return 0;<br />+<sp=
an style=3D"white-space: pre;">=09</span>}<br />+<br />=C2=A0<span style=3D=
"white-space: pre;">=09</span>sk =3D nr_find_listener(dest);<br />=C2=A0<br=
 />=C2=A0<span style=3D"white-space: pre;">=09</span>user =3D (ax25_address=
 *)(skb-&gt;data + 21);<br />@@ -1005,7 +1015,7 @@ int nr_rx_frame(struct s=
k_buff *skb, struct net_device *dev)<br />=C2=A0<span style=3D"white-space:=
 pre;">=09=09</span>nr_make-&gt;window =3D window;<br />=C2=A0<br />=C2=A0<=
span style=3D"white-space: pre;">=09</span>/* L4 timeout negotiation */<br =
/>-<span style=3D"white-space: pre;">=09</span>if (skb-&gt;len =3D=3D 37) {=
<br />+<span style=3D"white-space: pre;">=09</span>if (skb-&gt;len =3D=3D 3=
7 &amp;&amp; pskb_may_pull(skb, 37)) {<br />=C2=A0<span style=3D"white-spac=
e: pre;">=09=09</span>timeout =3D skb-&gt;data[36] * 256 + skb-&gt;data[35]=
;<br />=C2=A0<span style=3D"white-space: pre;">=09=09</span>if (timeout * H=
Z &lt; nr_make-&gt;t1)<br />=C2=A0<span style=3D"white-space: pre;">=09=09=
=09</span>nr_make-&gt;t1 =3D timeout * HZ;<br />diff --git a/net/netrom/nr_=
route.c b/net/netrom/nr_route.c<br />index b94cb2ffbaf8..b4b0ee546799 10064=
4<br />--- a/net/netrom/nr_route.c<br />+++ b/net/netrom/nr_route.c<br />@@=
 -758,7 +758,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)<br=
 />=C2=A0<span style=3D"white-space: pre;">=09</span>=C2=A0* Reject malform=
ed packets early. Check that it contains at least 2<br />=C2=A0<span style=
=3D"white-space: pre;">=09</span>=C2=A0* addresses and 1 byte more for Time=
-To-Live<br />=C2=A0<span style=3D"white-space: pre;">=09</span>=C2=A0*/<br=
 />-<span style=3D"white-space: pre;">=09</span>if (skb-&gt;len &lt; 2 * si=
zeof(ax25_address) + 1)<br />+<span style=3D"white-space: pre;">=09</span>i=
f (skb-&gt;len &lt; NR_NETWORK_LEN)<br />=C2=A0<span style=3D"white-space: =
pre;">=09=09</span>return 0;<br />=C2=A0<br />=C2=A0<span style=3D"white-sp=
ace: pre;">=09</span>nr_src =C2=A0=3D (ax25_address *)(skb-&gt;data + 0);<b=
r />-- <br />2.39.3 (Apple Git-146)<br /><br />
------=_Part_20365_1406235946.1756145012131--

------=_Part_20364_1528825248.1756145012131--

