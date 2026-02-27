Return-Path: <netdev+bounces-261927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBQpJJHUoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:29:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B21BB78B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD063013784
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE81346AC3;
	Fri, 27 Feb 2026 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUXQbz05"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91552346A06
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213166; cv=none; b=uzleVMaBCmO76lim2iekDRik1avf2k8K/MyyhUBAKGJ5ow5HOHymW+No9Lohkg17t+NKzTmxuoFfcAio+UURN8DkXybCqKKnA8izoI4W6ZPkLHw7q0kOjTnZcn0Om73Ap7VuGqNxWGTES6RkJZWwMzTesj2XBUHU3LtoxJJKNPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213166; c=relaxed/simple;
	bh=9I6ClW1L6bAMPVGpV5W2x7hwHAuuUSTlzBgEr/PRYf4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BDS8iK5O1AQm8es9/Ld8ntA8huYoPpm+f0dE+3OnB8zI1uPUTjzaFPOeM8jWkrYW2Nn0F3eU79do2Wszot6WVdHcJ4QRXplyDXYoNgOBjr/KN/RrvDhB2VHOzybfLIodJNZcYJ6tm6DdzT89fbjmp4FEHi1VTiZ/R+i3ZOshBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUXQbz05; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-79880325afdso7000237b3.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772213164; x=1772817964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MyEWqsciPhm9V3vSls7BzmfzlTV3Gq3wIOECFQ6NJB4=;
        b=iUXQbz05YM8i6fZt+1kHeBq6CrZla6GufD5dmtAM/5o3H8PW2MEGP320w0TYyYB6xk
         h5wcpaYpHqm8LsDI9rfHJYvuWBh1aw89TIEmVYXEIoJI2no/OAMT1xzCjltAghFlO3F2
         dkRfik+3hXP7EDhAbNCT0kPtlTb4XjuY0esjLvsgEtGVq+DclNBJ51tJbcYrHnflgvWO
         Jd44Ihn1+wmqQ8EbwQWzeM7Cm4A5DH3zxATpwgh2gfuAXdl89voGPeVBCAyWAMIq7Y6c
         rSJwDxXed7BfDJm4DIKZj4oZgzY3v6jUnMEXFvGcfdV4hKw09Vbbnbpn2jMCxNZCGPfN
         96kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772213164; x=1772817964;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MyEWqsciPhm9V3vSls7BzmfzlTV3Gq3wIOECFQ6NJB4=;
        b=PPoUUkpjSM2+eaMsWq7vSLPjlnWKeLHJmECZTSO9aE/XzH+U54EogvKnFxpWPJo1Z9
         7sGE0h45Vt2bHuXIzYQtd5t2pb8TtEzVi3rCJWFZa1HM9NGXVb+0M8ZZ/63WSRxrgDYH
         7SVavbJcxjW74OU3X7gxAyWlY+on/PeR7h+3bHQGjYd00t2dr61RDcYtr+vtk4/BadOG
         jDbAzmg588ju501VwgIaCt0T6jgkyv2jo4JOyvZlXaOur0ngOmv5kdOoSzWcyk6tCkBK
         qX3fPmYMKZICotiNsrqtmeTX/UqIMJkliZcnWo7bNRimbmjhKLw5xbvmigttsZ1AjMAu
         aLYA==
X-Forwarded-Encrypted: i=1; AJvYcCX/nj1XPAYIZB6tWeDmR+Zrlc9pNlD3TAosQ6Njq+Ze1+Da0f4T6K5Sqjm7Fh06lrt6h8bgaB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5vOdyaP6ox4rdWT4DRzWtdoDncVk9CEkbY7GzsNmbDqgqFl8
	zeLddeScbMzI86KjrESQ43cjMLaTnDculPQAMXRpbr3QEKRqMTkkwl+QzMshANjrQ81ZyIs5Am/
	ZcK4JlV05bmJe5g==
X-Received: from yxbbc10.prod.google.com ([2002:a05:690e:1a4a:b0:64a:dd99:5a2d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:4b01:b0:797:a162:f7c1 with SMTP id 00721157ae682-7988547cfe9mr33075657b3.16.1772213164301;
 Fri, 27 Feb 2026 09:26:04 -0800 (PST)
Date: Fri, 27 Feb 2026 17:26:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227172603.1700433-1-edumazet@google.com>
Subject: [PATCH net] indirect_call_wrapper: do not reevaluate function pointer
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261927-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E44B21BB78B
X-Rspamd-Action: no action

We have an increasing number of READ_ONCE(xxx->function)
combined with INDIRECT_CALL_[1234]() helpers.

Unfortunately this forces INDIRECT_CALL_[1234]() to read
xxx->function many times, which is not what we wanted.

Fix these macros so that xxx->function value is not reloaded.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux
add/remove: 0/0 grow/shrink: 1/65 up/down: 122/-1084 (-962)
Function                                     old     new   delta
ip_push_pending_frames                        59     181    +122
ip6_finish_output                            687     681      -6
__udp_enqueue_schedule_skb                  1078    1072      -6
ioam6_output                                2319    2312      -7
xfrm4_rcv_encap_finish2                       64      56      -8
xfrm4_output                                 297     289      -8
vrf_ip_local_out                             278     270      -8
vrf_ip6_local_out                            278     270      -8
seg6_input_finish                             64      56      -8
rpl_output                                   700     692      -8
ipmr_forward_finish                          124     116      -8
ip_forward_finish                            143     135      -8
ip6mr_forward2_finish                        100      92      -8
ip6_forward_finish                            73      65      -8
input_action_end_bpf                        1091    1083      -8
dst_input                                     52      44      -8
__xfrm6_output                               801     793      -8
__xfrm4_output                                83      75      -8
bpf_input                                    500     491      -9
__tcp_check_space                            530     521      -9
input_action_end_dt6                         291     280     -11
vti6_tnl_xmit                               1634    1622     -12
bpf_xmit                                    1203    1191     -12
rpl_input                                    497     483     -14
rawv6_send_hdrinc                           1355    1341     -14
ndisc_send_skb                              1030    1016     -14
ipv6_srh_rcv                                1377    1363     -14
ip_send_unicast_reply                       1253    1239     -14
ip_rcv_finish                                226     212     -14
ip6_rcv_finish                               300     286     -14
input_action_end_x_core                      205     191     -14
input_action_end_x                           355     341     -14
input_action_end_t                           205     191     -14
input_action_end_dx6_finish                  127     113     -14
input_action_end_dx4_finish                  373     359     -14
input_action_end_dt4                         426     412     -14
input_action_end_core                        186     172     -14
input_action_end_b6_encap                    292     278     -14
input_action_end_b6                          198     184     -14
igmp6_send                                  1332    1318     -14
ip_sublist_rcv                               864     848     -16
ip6_sublist_rcv                             1091    1075     -16
ipv6_rpl_srh_rcv                            1937    1920     -17
xfrm_policy_queue_process                   1246    1228     -18
seg6_output_core                             903     885     -18
mld_sendpack                                 856     836     -20
NF_HOOK                                      756     736     -20
vti_tunnel_xmit                             1447    1426     -21
input_action_end_dx6                         664     642     -22
input_action_end                            1502    1480     -22
sock_sendmsg_nosec                           134     111     -23
ip6mr_forward2                               388     364     -24
sock_recvmsg_nosec                           134     109     -25
seg6_input_core                              836     810     -26
ip_send_skb                                  172     146     -26
ip_local_out                                 140     114     -26
ip6_local_out                                140     114     -26
__sock_sendmsg                               162     136     -26
__ip_queue_xmit                             1196    1170     -26
__ip_finish_output                           405     379     -26
ipmr_queue_fwd_xmit                          373     346     -27
sock_recvmsg                                 173     145     -28
ip6_xmit                                    1635    1607     -28
xfrm_output_resume                          1418    1389     -29
ip_build_and_send_pkt                        625     591     -34
dst_output                                   504     432     -72
Total: Before=25217686, After=25216724, chg -0.00%

Fixes: 283c16a2dfd3 ("indirect call wrappers: helpers to speed-up indirect calls of builtin")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/indirect_call_wrapper.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index 35227d47cfc98c14f80a17a01d8df6050c56768e..dc272b514a01b8b318dbcffec6c46a359ee5e767 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -16,22 +16,26 @@
  */
 #define INDIRECT_CALL_1(f, f1, ...)					\
 	({								\
-		likely(f == f1) ? f1(__VA_ARGS__) : f(__VA_ARGS__);	\
+		typeof(f) __f1 = (f);					\
+		likely(__f1 == f1) ? f1(__VA_ARGS__) : __f1(__VA_ARGS__);	\
 	})
 #define INDIRECT_CALL_2(f, f2, f1, ...)					\
 	({								\
-		likely(f == f2) ? f2(__VA_ARGS__) :			\
-				  INDIRECT_CALL_1(f, f1, __VA_ARGS__);	\
+		typeof(f) __f2 = (f);					\
+		likely(__f2 == f2) ? f2(__VA_ARGS__) :			\
+				  INDIRECT_CALL_1(__f2, f1, __VA_ARGS__);	\
 	})
 #define INDIRECT_CALL_3(f, f3, f2, f1, ...)					\
 	({									\
-		likely(f == f3) ? f3(__VA_ARGS__) :				\
-				  INDIRECT_CALL_2(f, f2, f1, __VA_ARGS__);	\
+		typeof(f) __f3 = (f);						\
+		likely(__f3 == f3) ? f3(__VA_ARGS__) :				\
+				  INDIRECT_CALL_2(__f3, f2, f1, __VA_ARGS__);	\
 	})
 #define INDIRECT_CALL_4(f, f4, f3, f2, f1, ...)					\
 	({									\
-		likely(f == f4) ? f4(__VA_ARGS__) :				\
-				  INDIRECT_CALL_3(f, f3, f2, f1, __VA_ARGS__);	\
+		typeof(f) __f4 = (f);						\
+		likely(__f4 == f4) ? f4(__VA_ARGS__) :				\
+				  INDIRECT_CALL_3(__f4, f3, f2, f1, __VA_ARGS__);	\
 	})
 
 #define INDIRECT_CALLABLE_DECLARE(f)	f
-- 
2.53.0.473.g4a7958ca14-goog


