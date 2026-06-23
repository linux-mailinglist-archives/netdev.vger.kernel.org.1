Return-Path: <netdev+bounces-301447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ClKI+/IOmqNGwgAu9opvQ
	(envelope-from <netdev+bounces-301447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:57:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E28906B94BE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:57:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DNier4Ss;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301447-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301447-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E498313C3A8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778043905EB;
	Tue, 23 Jun 2026 17:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A638C2D8
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237029; cv=none; b=ikbRlfZYRcAWTW25xlth7LFy6GJ8bNk71ic4q5f2gol63GdveDlZ4/AWTVdZM33Leo9GD2xaMi0yqaf0WRf/qMLiviT68rfyPhHGALxcjArAo0REWzdBHsweHUwSm+FFvwHKsUsJYyRr2w4q248mxIQ0SrwXRWmbsdYmiy0bLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237029; c=relaxed/simple;
	bh=Dncsl8hjow3sp5pjKm6V4EDJXcJpgTPCOvtkvu4LLdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t80KYR9J2QYbSbgOft9YFH6INOL/rn3cf6jyt4kPXLzHAL5Ml1kUxQoM7ctY6wM+PUUrIHFtsP7glYUh0JoOBo2EPp8OKC7KG38e0rZJ/wmW5ALGf/RdNqMAkSl9KhKvElD8ZL+HT4gS4q1/iJRhE0Q874xrTT1/gfjE/dpLWCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNier4Ss; arc=none smtp.client-ip=209.85.160.41
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43cce34c881so157797fac.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237026; x=1782841826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUHIgRWXidQgCL8N0VtuYnG+an2QyvMnaRHa4g/3f4Y=;
        b=DNier4SsSCW9zYRxas5n5S+aFUW8wuuR/TTEGWERG9GKIqy2CtVFnj+Wn6aFGGURoY
         4akHnG3mDDXBcdgEThhkOAqa9lSO6sAEhsBuuuOaem97/irVbq1qDedS9Tk194T5EREw
         8aPYfmxhcO2ArzFpmlbYR2J+hkwm1WUXU85WTmZp8iexGz/wOaV9Np3hJwXu4xDzVOtm
         pWFW2bbq7yROnVdBQNdS45UVYyMjjMO0I9TRPXtjcth7tfyaYok2yMI77vAVC4lwsHhq
         DvPi9pjwsyt/FrhzxjCcisZsG8GmlZkigyWe/FD0/bMuM9ZTdWoYQUyuX6do9LNoiyWZ
         HiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237026; x=1782841826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gUHIgRWXidQgCL8N0VtuYnG+an2QyvMnaRHa4g/3f4Y=;
        b=HUjliTGTpezYkqkwZ67RHKGgBxudcwlIjqRHV5JGM0qf0XjF+JjnQE3+tSKUn3MwEl
         d2vM4kM1jWUIVO2wvgNA7NsA2UlC6VZX8Sy47OHEbRxH3+TlMwrPv9lWRNo1qLHPSyQ9
         3ud7rw6Kcz1jqCMQlemR+yETpLCscQYRSlJ7C9agxo7EXC/QjeknxQa5D3KE7DjfTWBq
         OCfQCmFNDBvX9/Cbg+jGXizYz1BCn60gd5NQcBmrbTV1JM2HW47mdpsmap1zuhfVA7Nk
         LSG2vZBTbH9Idw4Z6cPncgv6wZd1Xrvd1t9emVzxKiZpjKoZ/Vq7/5FJBVQzxu/EJoPM
         qVhw==
X-Gm-Message-State: AOJu0YyX4IPQX1bRf22hioxCnLksgPMMSGjJyyj0zodKXm85KF+p51Xx
	6M+LEO8ds1xgsXGeSeAfFgoDkxl5GclWqxO5St9a8rLsXZat0jE31jjr
X-Gm-Gg: AfdE7cnN0691oazT49DFbF7dDIBpxUePCbnXnI4ejZH8MvZBiJJFmHU7MRtvLKBfTX/
	2GEIsLEljCl7Gea7T/YxfLgIrc35NyBSwI1G2qDlvyRmFdncAT4kRzA36LpmHdRR/WRNvjXMP7D
	bdCdxi15ORs8WoffXj4SLUNZR56qY0YddwBISxd1REKk40oiign+NOfe67c2imjo7/qsqACnpr1
	/BSdM49hGUzb5Nq0121tcrQLFfmqBecFYt2FBGg9KJBDheCOkj2m7NSXW2ubiXN7dBqOsIQS/Xs
	wi+dazs7REg9KuW0wlScl4n8Fa4owR8uRKp+IrDsvvBLM0griKd1qeyRTszZGZqNvGS8B0JHLif
	ho0mifZavt1rZwky01H/wc0ntRJ4Lz0DaLVcjtpknUgxWXTVJigwfB63COBIWni7IQ2pa79H9OW
	gbrpo=
X-Received: by 2002:a05:6808:180b:b0:489:b4b1:56a9 with SMTP id 5614622812f47-489b4c09bf0mr14766183b6e.37.1782237025986;
        Tue, 23 Jun 2026 10:50:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944069d22sm9382628a34.10.2026.06.23.10.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 12/15] bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops
Date: Tue, 23 Jun 2026 10:50:00 -0700
Message-ID: <20260623175006.3136053-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-301447-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E28906B94BE

Add the TCP header option callbacks to the bpf_tcp_ops struct_ops type:

  parse_hdr     - parse the options of an incoming skb on an established
                  connection
  hdr_opt_len   - reserve space in the TCP header for bpf options
  write_hdr_opt - write the reserved bpf options

These mirror the BPF_SOCK_OPS_PARSE_HDR_OPT_CB, _HDR_OPT_LEN_CB and
_WRITE_HDR_OPT_CB legacy sockops callbacks, but are exposed as struct_ops
members so a program can implement them with normal function signatures
and per-member helper sets.

The reserved header window is shared between the legacy sockops and
bpf_tcp_ops paths. tcp_{syn,synack,established}_options() first run the
legacy BPF_SOCK_OPS_HDR_OPT_LEN_CB and then call hdr_opt_len, so both
sources accumulate into opts->bpf_opt_len; at write time the legacy
options are emitted first and bpf_tcp_ops writes after them.

API design

bpf_tcp_ops overloads the sock_ops header-option helpers rather than
introducing a new API: bpf_reserve_hdr_opt(), bpf_store_hdr_opt() and
bpf_load_hdr_opt() are exposed per-member (reserve for hdr_opt_len,
store/load for write_hdr_opt, load for parse_hdr) and share the existing
kernel option-walking core via _bpf_sock_ops{store,load}hdr_opt(), with
the bpf_tcp_ops wrappers synthesizing a temporary bpf_sock_ops_kern from
the program ctx. This keeps a port from the legacy
BPF_SOCK_OPS*_HDR_OPT_CB callbacks mechanical (same helper calls) and
adds no new UAPI helper/kfunc surface.

An alternative considered was to drop the option helpers entirely: have
hdr_opt_len reserve space purely through its return value, and introduce
a dedicated TCP-header-option dynptr used for both reading and writing.
That is a cleaner, more self-contained interface, but it is a larger
change and does not reuse the legacy helpers, making a port from sockops
less mechanical. It can be pursued as a follow-up; the helper-based
interface here keeps this series focused on moving the hooks to
struct_ops.

The hdr_opt_len fast path in tcp_established_options() is gated by
cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS). Note this is a global,
per-attach-type static branch: it is enabled whenever any bpf_tcp_ops is
attached, even one that does not implement hdr_opt_len or that is attached
to a different cgroup. In those cases the block still runs but
bpf_tcp_ops_hdr_opt_len() no-ops via the per-member check in the dispatch
macro. A per-member/per-cgroup gate could be added later if the extra
fast-path work proves measurable.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/filter.h         |   5 ++
 include/net/tcp.h              |  40 ++++++++++
 include/uapi/linux/bpf.h       |  35 ++++++---
 net/core/filter.c              |  32 +++++---
 net/ipv4/bpf_tcp_ops.c         | 139 ++++++++++++++++++++++++++++++++-
 net/ipv4/tcp_input.c           |  13 +++
 net/ipv4/tcp_output.c          |  46 +++++++++++
 tools/include/uapi/linux/bpf.h |  35 ++++++---
 8 files changed, 306 insertions(+), 39 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 67d337ede91b..fe28db65fb6a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1843,6 +1843,11 @@ static __always_inline long __bpf_xdp_redirect_map(struct bpf_map *map, u64 inde
 	return XDP_REDIRECT;
 }
 
+int __bpf_sock_ops_load_hdr_opt(struct bpf_sock_ops_kern *bpf_sock,
+				void *search_res, u32 len, u64 flags);
+int __bpf_sock_ops_store_hdr_opt(struct bpf_sock_ops_kern *bpf_sock,
+				 const void *from, u32 len, u64 flags);
+
 #ifdef CONFIG_NET
 int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to, u32 len);
 int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2102f9f2afd6..7bf702117602 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3005,6 +3005,45 @@ struct bpf_tcp_ops {
 
 	/* Called on listen(2), right after the socket enters TCP_LISTEN. */
 	void (*listen)(struct sock *sk);
+
+	/* Parse the TCP header options of an incoming skb received on an
+	 * established connection. Use bpf_dynptr_from_skb()/bpf_skb_load_bytes()
+	 * to access the options.
+	 */
+	void (*parse_hdr)(struct sock *sk, struct sk_buff *skb);
+
+	/* Reserve space in the outgoing TCP header for options to be written
+	 * later by write_hdr_opt(). Call bpf_reserve_hdr_opt() to reserve bytes.
+	 *
+	 * @skb: outgoing packet. NULL when called from tcp_current_mss()
+	 *       (MSS sizing).
+	 * @req: request_sock on the synack path; NULL otherwise.
+	 * @syn_skb: incoming SYN on the synack path; NULL otherwise.
+	 * @synack_type: TCP_SYNACK_COOKIE indicates a stateless syncookie.
+	 * @remaining: pointer to the size of space still available; cast it
+	 *             using bpf_rdonly_cast() before dereferencing.
+	 */
+	void (*hdr_opt_len)(struct sock *sk, struct sk_buff *skb,
+			    struct request_sock *req, struct sk_buff *syn_skb,
+			    enum tcp_synack_type synack_type,
+			    unsigned int *remaining);
+
+	/* Write header options into the space reserved earlier by hdr_opt_len().
+	 * Use bpf_store_hdr_opt() to write; it appends within the reserved window
+	 * shared with legacy SOCKOPS.
+	 *
+	 * @skb: outgoing packet.
+	 * @req: request_sock on the synack path; NULL otherwise.
+	 * @syn_skb: incoming SYN on the synack path; NULL otherwise.
+	 * @synack_type: TCP_SYNACK_COOKIE indicates a stateless syncookie.
+	 * @opt_off: offset in the outgoing @skb's TCP header where the
+	 *	     bpf_tcp_ops portion of the reserved window begins, i.e. after
+	 *	     the kernel and legacy options.
+	 */
+	void (*write_hdr_opt)(struct sock *sk, struct sk_buff *skb,
+			      struct request_sock *req, struct sk_buff *syn_skb,
+			      enum tcp_synack_type synack_type,
+			      u32 opt_off);
 };
 
 #define bpf_tcp_ops_call(op, sk, ...)					\
@@ -3056,6 +3095,7 @@ do {									\
 	}								\
 	__retval;							\
 })
+
 #else
 #define bpf_tcp_ops_call(op, sk, ...)		do { } while (0)
 #define bpf_tcp_ops_call_int(op, init_retval, sk, ...)	(init_retval)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2b84c69eb814..45b9ee29e461 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4799,15 +4799,18 @@ union bpf_attr {
  * 		The non-negative copied *buf* length equal to or less than
  * 		*size* on success, or a negative error in case of failure.
  *
- * long bpf_load_hdr_opt(struct bpf_sock_ops *skops, void *searchby_res, u32 len, u64 flags)
+ * long bpf_load_hdr_opt(void *ctx, void *searchby_res, u32 len, u64 flags)
  *	Description
  *		Load header option.  Support reading a particular TCP header
- *		option for bpf program (**BPF_PROG_TYPE_SOCK_OPS**).
+ *		option for bpf program (**BPF_PROG_TYPE_SOCK_OPS**).  For the
+ *		**bpf_tcp_ops** struct_ops, this helper can be called from the
+ *		**parse_hdr**\ () and **write_hdr_opt**\ () operators.
  *
- *		If *flags* is 0, it will search the option from the
- *		*skops*\ **->skb_data**.  The comment in **struct bpf_sock_ops**
- *		has details on what skb_data contains under different
- *		*skops*\ **->op**.
+ *		If *flags* is 0, it will search the option from the packet
+ *		associated with the current operation.  For
+ *		**BPF_PROG_TYPE_SOCK_OPS**, the comment in
+ *		**struct bpf_sock_ops** has details on what skb_data
+ *		contains under different *op*.
  *
  *		The first byte of the *searchby_res* specifies the
  *		kind that it wants to search.
@@ -4840,6 +4843,8 @@ union bpf_attr {
  *
  *		* **BPF_LOAD_HDR_OPT_TCP_SYN** to search from the
  *		  saved_syn packet or the just-received syn packet.
+ *		  Not supported by the **bpf_tcp_ops** struct_ops, which
+ *		  rejects all flags.
  *
  *	Return
  *		> 0 when found, the header option is copied to *searchby_res*.
@@ -4860,9 +4865,9 @@ union bpf_attr {
  *		packet.
  *
  *		**-EPERM** if the helper cannot be used under the current
- *		*skops*\ **->op**.
+ *		operation.
  *
- * long bpf_store_hdr_opt(struct bpf_sock_ops *skops, const void *from, u32 len, u64 flags)
+ * long bpf_store_hdr_opt(void *ctx, const void *from, u32 len, u64 flags)
  *	Description
  *		Store header option.  The data will be copied
  *		from buffer *from* with length *len* to the TCP header.
@@ -4878,7 +4883,9 @@ union bpf_attr {
  *		by searching the same option in the outgoing skb.
  *
  *		This helper can only be called during
- *		**BPF_SOCK_OPS_WRITE_HDR_OPT_CB**.
+ *		**BPF_SOCK_OPS_WRITE_HDR_OPT_CB**, or from the
+ *		**write_hdr_opt**\ () operator of the **bpf_tcp_ops**
+ *		struct_ops.
  *
  *	Return
  *		0 on success, or negative error in case of failure:
@@ -4893,9 +4900,9 @@ union bpf_attr {
  *		**-EFAULT** on failure to parse the existing header options.
  *
  *		**-EPERM** if the helper cannot be used under the current
- *		*skops*\ **->op**.
+ *		operation.
  *
- * long bpf_reserve_hdr_opt(struct bpf_sock_ops *skops, u32 len, u64 flags)
+ * long bpf_reserve_hdr_opt(void *ctx, u32 len, u64 flags)
  *	Description
  *		Reserve *len* bytes for the bpf header option.  The
  *		space will be used by **bpf_store_hdr_opt**\ () later in
@@ -4905,7 +4912,9 @@ union bpf_attr {
  *		the total number of bytes will be reserved.
  *
  *		This helper can only be called during
- *		**BPF_SOCK_OPS_HDR_OPT_LEN_CB**.
+ *		**BPF_SOCK_OPS_HDR_OPT_LEN_CB**, or from the
+ *		**hdr_opt_len**\ () operator of the **bpf_tcp_ops**
+ *		struct_ops.
  *
  *	Return
  *		0 on success, or negative error in case of failure:
@@ -4915,7 +4924,7 @@ union bpf_attr {
  *		**-ENOSPC** if there is not enough space in the header.
  *
  *		**-EPERM** if the helper cannot be used under the current
- *		*skops*\ **->op**.
+ *		operation.
  *
  * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *value, u64 flags)
  *	Description
diff --git a/net/core/filter.c b/net/core/filter.c
index f85578772930..dc44ffb7a380 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7885,17 +7885,14 @@ static const u8 *bpf_search_tcp_opt(const u8 *op, const u8 *opend,
 	return ERR_PTR(-ENOMSG);
 }
 
-BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
-	   void *, search_res, u32, len, u64, flags)
+int __bpf_sock_ops_load_hdr_opt(struct bpf_sock_ops_kern *bpf_sock,
+				void *search_res, u32 len, u64 flags)
 {
 	bool eol, load_syn = flags & BPF_LOAD_HDR_OPT_TCP_SYN;
 	const u8 *op, *opend, *magic, *search = search_res;
 	u8 search_kind, search_len, copy_len, magic_len;
 	int ret;
 
-	if (!is_locked_tcp_sock_ops(bpf_sock))
-		return -EOPNOTSUPP;
-
 	/* 2 byte is the minimal option len except TCPOPT_NOP and
 	 * TCPOPT_EOL which are useless for the bpf prog to learn
 	 * and this helper disallow loading them also.
@@ -7956,6 +7953,15 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
 	return ret;
 }
 
+BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
+	   void *, search_res, u32, len, u64, flags)
+{
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;
+
+	return __bpf_sock_ops_load_hdr_opt(bpf_sock, search_res, len, flags);
+}
+
 static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
 	.func		= bpf_sock_ops_load_hdr_opt,
 	.gpl_only	= false,
@@ -7966,17 +7972,14 @@ static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
 	.arg4_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_4(bpf_sock_ops_store_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
-	   const void *, from, u32, len, u64, flags)
+int __bpf_sock_ops_store_hdr_opt(struct bpf_sock_ops_kern *bpf_sock,
+				 const void *from, u32 len, u64 flags)
 {
 	u8 new_kind, new_kind_len, magic_len = 0, *opend;
 	const u8 *op, *new_op, *magic = NULL;
 	struct sk_buff *skb;
 	bool eol;
 
-	if (bpf_sock->op != BPF_SOCK_OPS_WRITE_HDR_OPT_CB)
-		return -EPERM;
-
 	if (len < 2 || flags)
 		return -EINVAL;
 
@@ -8034,6 +8037,15 @@ BPF_CALL_4(bpf_sock_ops_store_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
 	return 0;
 }
 
+BPF_CALL_4(bpf_sock_ops_store_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
+	   const void *, from, u32, len, u64, flags)
+{
+	if (bpf_sock->op != BPF_SOCK_OPS_WRITE_HDR_OPT_CB)
+		return -EPERM;
+
+	return __bpf_sock_ops_store_hdr_opt(bpf_sock, from, len, flags);
+}
+
 static const struct bpf_func_proto bpf_sock_ops_store_hdr_opt_proto = {
 	.func		= bpf_sock_ops_store_hdr_opt,
 	.gpl_only	= false,
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index cf53c95a0dbc..0c7352517ac3 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_verifier.h>
+#include <linux/filter.h>
 #include <net/bpf_sk_storage.h>
 #include <net/tcp.h>
 
@@ -55,6 +56,26 @@ static void listen_stub(struct sock *sk)
 {
 }
 
+static void parse_hdr_stub(struct sock *sk, struct sk_buff *skb)
+{
+}
+
+static void hdr_opt_len_stub(struct sock *sk, struct sk_buff *skb__nullable,
+			     struct request_sock *req__nullable,
+			     struct sk_buff *syn_skb__nullable,
+			     enum tcp_synack_type synack_type,
+			     unsigned int *remaining)
+{
+}
+
+static void write_hdr_opt_stub(struct sock *sk, struct sk_buff *skb,
+			       struct request_sock *req__nullable,
+			       struct sk_buff *syn_skb__nullable,
+			       enum tcp_synack_type synack_type,
+			       u32 opt_off)
+{
+}
+
 static struct bpf_tcp_ops __bpf_tcp_ops = {
 	.timeout_init = timeout_init_stub,
 	.rwnd_init = rwnd_init_stub,
@@ -66,6 +87,99 @@ static struct bpf_tcp_ops __bpf_tcp_ops = {
 	.retrans = retrans_stub,
 	.connect = connect_stub,
 	.listen = listen_stub,
+	.parse_hdr = parse_hdr_stub,
+	.hdr_opt_len = hdr_opt_len_stub,
+	.write_hdr_opt = write_hdr_opt_stub,
+};
+
+BPF_CALL_4(bpf_tcp_ops_store_hdr_opt, void *, ctx, const void *, from,
+	   u32, len, u64, flags)
+{
+	struct sk_buff *skb = ((struct sk_buff **)ctx)[1];
+	struct bpf_sock_ops_kern sock_ops = {};
+	u32 opt_off = ((u64 *)ctx)[5];
+	u8 *op, *opend;
+
+	/* bpf_tcp_ops does not keep track of the end of the written TCP header
+	 * options, so search for it every time the helper is called. The free
+	 * space is NOP-filled, so a TCPOPT_NOP ends the search rather than being
+	 * skipped as in a normal option walk in sockops.
+	 */
+	op = skb->data + opt_off;
+	opend = skb->data + tcp_hdrlen(skb);
+	while (op < opend && *op != TCPOPT_NOP) {
+		if (*op == TCPOPT_EOL || op + 1 >= opend || op[1] < 2)
+			break;
+		op += op[1];
+	}
+
+	sock_ops.skb = skb;
+	sock_ops.skb_data_end = op;
+	sock_ops.remaining_opt_len = opend - op;
+
+	return __bpf_sock_ops_store_hdr_opt(&sock_ops, from, len, flags);
+}
+
+static const struct bpf_func_proto bpf_tcp_ops_store_hdr_opt_proto = {
+	.func		= bpf_tcp_ops_store_hdr_opt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_4(bpf_tcp_ops_load_hdr_opt, void *, ctx, void *, search_res,
+	   u32, len, u64, flags)
+{
+	struct sk_buff *skb = ((struct sk_buff **)ctx)[1];
+	struct bpf_sock_ops_kern sock_ops = {};
+
+	/* No flags supported. In particular BPF_LOAD_HDR_OPT_TCP_SYN, which
+	 * loads from the saved SYN, is not available because bpf_tcp_ops has no
+	 * carrier to track the SYN source across the hooks.
+	 */
+	if (flags)
+		return -EINVAL;
+
+	sock_ops.skb = skb;
+	sock_ops.skb_data_end = skb->data + tcp_hdrlen(skb);
+
+	return __bpf_sock_ops_load_hdr_opt(&sock_ops, search_res, len, flags);
+}
+
+static const struct bpf_func_proto bpf_tcp_ops_load_hdr_opt_proto = {
+	.func		= bpf_tcp_ops_load_hdr_opt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_3(bpf_tcp_ops_reserve_hdr_opt, void *, ctx, u32, len, u64, flags)
+{
+	unsigned int *remaining = ((unsigned int **)ctx)[5];
+
+	if (flags || len < 2)
+		return -EINVAL;
+
+	if (len > *remaining)
+		return -ENOSPC;
+
+	*remaining -= len;
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_tcp_ops_reserve_hdr_opt_proto = {
+	.func		= bpf_tcp_ops_reserve_hdr_opt,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
 };
 
 BPF_CALL_0(bpf_tcp_ops_get_retval)
@@ -102,14 +216,20 @@ get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
 	case BPF_FUNC_setsockopt:
-		/* The listener is not locked. */
+		/* The sk may be an unlocked listener (synack path) or NULL
+		 * fullsock; disable for members that can run unlocked.
+		 */
 		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, timeout_init))
+		    moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
+		    moff == offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
+		    moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
 			return NULL;
 		return &bpf_sk_setsockopt_proto;
 	case BPF_FUNC_getsockopt:
 		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
-		    moff == offsetof(struct bpf_tcp_ops, timeout_init))
+		    moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
+		    moff == offsetof(struct bpf_tcp_ops, hdr_opt_len) ||
+		    moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
 			return NULL;
 		return &bpf_sk_getsockopt_proto;
 	case BPF_FUNC_get_retval:
@@ -117,6 +237,19 @@ get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		    moff == offsetof(struct bpf_tcp_ops, rwnd_init))
 			return &bpf_tcp_ops_get_retval_proto;
 		return NULL;
+	case BPF_FUNC_reserve_hdr_opt:
+		if (moff == offsetof(struct bpf_tcp_ops, hdr_opt_len))
+			return &bpf_tcp_ops_reserve_hdr_opt_proto;
+		return NULL;
+	case BPF_FUNC_load_hdr_opt:
+		if (moff == offsetof(struct bpf_tcp_ops, parse_hdr) ||
+		    moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
+			return &bpf_tcp_ops_load_hdr_opt_proto;
+		return NULL;
+	case BPF_FUNC_store_hdr_opt:
+		if (moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
+			return &bpf_tcp_ops_store_hdr_opt_proto;
+		return NULL;
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 12fb690d21c4..a36146789138 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -208,6 +208,18 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 }
 #endif
 
+static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *skb)
+{
+	switch (sk->sk_state) {
+	case TCP_SYN_RECV:
+	case TCP_SYN_SENT:
+	case TCP_LISTEN:
+		return;
+	}
+
+	bpf_tcp_ops_call(parse_hdr, sk, skb);
+}
+
 static __cold void tcp_gro_dev_warn(const struct sock *sk, const struct sk_buff *skb,
 				    unsigned int len)
 {
@@ -6431,6 +6443,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 
 pass:
 	bpf_skops_parse_hdr(sk, skb);
+	bpf_tcp_ops_parse_hdr(sk, skb);
 
 	return true;
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 93f4a95399ea..580652d0a135 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -573,6 +573,13 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 	if (nr_written < max_opt_len)
 		memset(skb->data + first_opt_off + nr_written, TCPOPT_NOP,
 		       max_opt_len - nr_written);
+
+	/* bpf_tcp_ops portion is NOP-filled (everything past the sockops
+	 * writer's bytes). The writer find the append point by scanning from
+	 * first_opt_off + nr_written to the first NOP.
+	 */
+	bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_type,
+			 first_opt_off + nr_written);
 }
 #else
 static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
@@ -594,6 +601,32 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 }
 #endif
 
+static u32 bpf_tcp_ops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
+				   struct request_sock *req,
+				   struct sk_buff *syn_skb,
+				   enum tcp_synack_type synack_type,
+				   struct tcp_out_options *opts,
+				   u32 remaining)
+{
+	unsigned int remaining_out = remaining, reserved;
+
+	if (!remaining)
+		return 0;
+
+	/* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining_out */
+	bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type, &remaining_out);
+
+	reserved = remaining - remaining_out;
+	if (!reserved)
+		return remaining;
+
+	/* round up to 4 bytes */
+	reserved = (reserved + 3) & ~3;
+
+	opts->bpf_opt_len += reserved;
+	return remaining - reserved;
+}
+
 static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
 				      const struct tcp_request_sock *tcprsk,
 				      struct tcp_out_options *opts,
@@ -1053,6 +1086,8 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 
 	remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
 					  remaining);
+	remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
+					    remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
@@ -1141,6 +1176,8 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	remaining = bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
 					  synack_type, opts, remaining);
+	remaining = bpf_tcp_ops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
+					    synack_type, opts, remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
@@ -1244,6 +1281,15 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		size = MAX_TCP_OPTION_SPACE - remaining;
 	}
 
+	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
+		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
+
+		remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
+						    remaining);
+
+		size = MAX_TCP_OPTION_SPACE - remaining;
+	}
+
 	return size;
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2b84c69eb814..45b9ee29e461 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4799,15 +4799,18 @@ union bpf_attr {
  * 		The non-negative copied *buf* length equal to or less than
  * 		*size* on success, or a negative error in case of failure.
  *
- * long bpf_load_hdr_opt(struct bpf_sock_ops *skops, void *searchby_res, u32 len, u64 flags)
+ * long bpf_load_hdr_opt(void *ctx, void *searchby_res, u32 len, u64 flags)
  *	Description
  *		Load header option.  Support reading a particular TCP header
- *		option for bpf program (**BPF_PROG_TYPE_SOCK_OPS**).
+ *		option for bpf program (**BPF_PROG_TYPE_SOCK_OPS**).  For the
+ *		**bpf_tcp_ops** struct_ops, this helper can be called from the
+ *		**parse_hdr**\ () and **write_hdr_opt**\ () operators.
  *
- *		If *flags* is 0, it will search the option from the
- *		*skops*\ **->skb_data**.  The comment in **struct bpf_sock_ops**
- *		has details on what skb_data contains under different
- *		*skops*\ **->op**.
+ *		If *flags* is 0, it will search the option from the packet
+ *		associated with the current operation.  For
+ *		**BPF_PROG_TYPE_SOCK_OPS**, the comment in
+ *		**struct bpf_sock_ops** has details on what skb_data
+ *		contains under different *op*.
  *
  *		The first byte of the *searchby_res* specifies the
  *		kind that it wants to search.
@@ -4840,6 +4843,8 @@ union bpf_attr {
  *
  *		* **BPF_LOAD_HDR_OPT_TCP_SYN** to search from the
  *		  saved_syn packet or the just-received syn packet.
+ *		  Not supported by the **bpf_tcp_ops** struct_ops, which
+ *		  rejects all flags.
  *
  *	Return
  *		> 0 when found, the header option is copied to *searchby_res*.
@@ -4860,9 +4865,9 @@ union bpf_attr {
  *		packet.
  *
  *		**-EPERM** if the helper cannot be used under the current
- *		*skops*\ **->op**.
+ *		operation.
  *
- * long bpf_store_hdr_opt(struct bpf_sock_ops *skops, const void *from, u32 len, u64 flags)
+ * long bpf_store_hdr_opt(void *ctx, const void *from, u32 len, u64 flags)
  *	Description
  *		Store header option.  The data will be copied
  *		from buffer *from* with length *len* to the TCP header.
@@ -4878,7 +4883,9 @@ union bpf_attr {
  *		by searching the same option in the outgoing skb.
  *
  *		This helper can only be called during
- *		**BPF_SOCK_OPS_WRITE_HDR_OPT_CB**.
+ *		**BPF_SOCK_OPS_WRITE_HDR_OPT_CB**, or from the
+ *		**write_hdr_opt**\ () operator of the **bpf_tcp_ops**
+ *		struct_ops.
  *
  *	Return
  *		0 on success, or negative error in case of failure:
@@ -4893,9 +4900,9 @@ union bpf_attr {
  *		**-EFAULT** on failure to parse the existing header options.
  *
  *		**-EPERM** if the helper cannot be used under the current
- *		*skops*\ **->op**.
+ *		operation.
  *
- * long bpf_reserve_hdr_opt(struct bpf_sock_ops *skops, u32 len, u64 flags)
+ * long bpf_reserve_hdr_opt(void *ctx, u32 len, u64 flags)
  *	Description
  *		Reserve *len* bytes for the bpf header option.  The
  *		space will be used by **bpf_store_hdr_opt**\ () later in
@@ -4905,7 +4912,9 @@ union bpf_attr {
  *		the total number of bytes will be reserved.
  *
  *		This helper can only be called during
- *		**BPF_SOCK_OPS_HDR_OPT_LEN_CB**.
+ *		**BPF_SOCK_OPS_HDR_OPT_LEN_CB**, or from the
+ *		**hdr_opt_len**\ () operator of the **bpf_tcp_ops**
+ *		struct_ops.
  *
  *	Return
  *		0 on success, or negative error in case of failure:
@@ -4915,7 +4924,7 @@ union bpf_attr {
  *		**-ENOSPC** if there is not enough space in the header.
  *
  *		**-EPERM** if the helper cannot be used under the current
- *		*skops*\ **->op**.
+ *		operation.
  *
  * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *value, u64 flags)
  *	Description
-- 
2.53.0-Meta


