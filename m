Return-Path: <netdev+bounces-291556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAdONCZDFWoOUAcAu9opvQ
	(envelope-from <netdev+bounces-291556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:52:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ECD5D156B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1DDF3008FEB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFF33C4141;
	Tue, 26 May 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="qIFyhMsp"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E23C37AC;
	Tue, 26 May 2026 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778330; cv=none; b=OektnI777rxA13pGqY9bEBBx6SDTJEMDLqZwIF+mBq/4neFlNhMUUitLrDkynKXqawneTgj36v0+8FEqbtHYdcjrIIkMAMfSmD0eOoI8ot1nZOTEMBARl9CwasryMjgHWRgGMgHhNv5lekoj1oppaeI0j9NgbC0F8i4QuHDeBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778330; c=relaxed/simple;
	bh=UZRc3kggpT5xBfJ5QCpE42yQBKoEj6SjU+Ar6L61mr8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=BMfQ/bSOvPoFFyUie+65mMy1u9ZAHjVUl4zRe+qVboW96J+J39y+rwh98M1EfQVpAmOqKf1zSpeIWLXjrBjGS0ZoQk9d2JSwAV2QVNgQqe/W6yjk56CBVl1kWJ+C9cdRALFIEgIDRFaXFKiAopKvMXwV7r8q8opFGsnBtac21f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=qIFyhMsp; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [192.168.2.17] (82-69-108-24.dsl.in-addr.zen.co.uk [82.69.108.24])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 4D0DB7D4AA;
	Tue, 26 May 2026 07:44:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1779777872; bh=UZRc3kggpT5xBfJ5QCpE42yQBKoEj6SjU+Ar6L61mr8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<c08da2f1-750f-257a-180e-f1af47451647@katalix.com>|
	 Date:=20Tue,=2026=20May=202026=2007:44:31=20+0100|MIME-Version:=20
	 1.0|To:=20Michael=20Bommarito=20<michael.bommarito@gmail.com>,=0D=
	 0A=20"David=20S=20.=20Miller"=20<davem@davemloft.net>,=20Eric=20Du
	 mazet=0D=0A=20<edumazet@google.com>,=20Jakub=20Kicinski=20<kuba@ke
	 rnel.org>,=0D=0A=20Paolo=20Abeni=20<pabeni@redhat.com>|Cc:=20Tom=2
	 0Parkin=20<tparkin@katalix.com>,=20Guillaume=20Nault=20<gnault@red
	 hat.com>,=0D=0A=20Simon=20Horman=20<horms@kernel.org>,=0D=0A=20Seb
	 astian=20Andrzej=20Siewior=20<bigeasy@linutronix.de>,=0D=0A=20Clar
	 k=20Williams=20<clrkwllms@kernel.org>,=20Steven=20Rostedt=20<roste
	 dt@goodmis.org>,=0D=0A=20Kees=20Cook=20<kees@kernel.org>,=20netdev
	 @vger.kernel.org,=0D=0A=20linux-rt-devel@lists.linux.dev,=20linux-
	 kernel@vger.kernel.org|References:=20<20260523023423.2568972-1-mic
	 hael.bommarito@gmail.com>|From:=20James=20Chapman=20<jchapman@kata
	 lix.com>|Subject:=20Re:=20[PATCH=20net]=20l2tp:=20use=20refcount_i
	 nc_not_zero=20in=0D=0A=20l2tp_session_get_by_ifname|In-Reply-To:=2
	 0<20260523023423.2568972-1-michael.bommarito@gmail.com>;
	b=qIFyhMsp37rN+Wj54G2Ha2xelNHnO2G37L3YHpj/VNJTWAxSwZJbx2cVEIMoiG77f
	 6qmer9QWiZudbszcoERZ87MQuW+zepLi2LSwJFEJL7Me0uAiemzKRKfk53ZJp9p2/L
	 lzGKS2uqwSS7tlzJ8yv3yY9FDy5xuFSQ87pVzL3eKp44sRvA2uxVUCa3DrlHXPbMh6
	 hgEuJhWfD4RPpC+Q08qVmy/bbfYtLUEF7IRRa93Z4RWVKIDnqVfW10IUvlOh1dVocK
	 CmwDOA05OzcpqUEYkpwKKPXrCnaR6Y5ugrLAVBwEFt9bROwGqsKBcCQjY3X4DczASf
	 9yuW3awYTactA==
Message-ID: <c08da2f1-750f-257a-180e-f1af47451647@katalix.com>
Date: Tue, 26 May 2026 07:44:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Michael Bommarito <michael.bommarito@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Tom Parkin <tparkin@katalix.com>, Guillaume Nault <gnault@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Kees Cook <kees@kernel.org>, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260523023423.2568972-1-michael.bommarito@gmail.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net] l2tp: use refcount_inc_not_zero in
 l2tp_session_get_by_ifname
In-Reply-To: <20260523023423.2568972-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[katalix.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[katalix.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291556-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jchapman@katalix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[katalix.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C3ECD5D156B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/05/2026 03:34, Michael Bommarito wrote:

> A reader in l2tp_session_get_by_ifname() can return a pointer to a
> session whose refcount has reached zero. The getter takes its
> reference with plain refcount_inc(), but every other session getter
> in the same file (l2tp_v2_session_get, l2tp_v3_session_get, and the
> corresponding _get_next variants) uses refcount_inc_not_zero()
> because the IDR/RCU lookup can race with refcount_dec_and_test() ->
> l2tp_session_free() -> kfree_rcu(). The ifname getter is the only
> outlier; the inconsistency was raised on-list after 979c017803c4
> ("l2tp: use list_del_rcu in l2tp_session_unhash").
>
> A reader inside rcu_read_lock_bh() that matches session->ifname can
> be preempted between the strcmp() and the refcount_inc(). If the
> last reference drops on another CPU in that window, the reader's
> refcount_inc() runs on a counter that has reached zero. refcount_t
> catches the addition-on-zero, prints "refcount_t: addition on 0;
> use-after-free", saturates the counter, and returns the saturated
> pointer to the caller. Session memory is held live by the in-flight
> RCU read section, but the kfree_rcu() callback queued from
> l2tp_session_free() will free it once the grace period closes; a
> caller that dereferences the returned session past that point hits
> a slab-use-after-free. On PREEMPT_RT local_bh_disable() is a per-CPU
> sleeping lock and the preemption window is real; on stock PREEMPT
> kernels local_bh_disable() is a preempt_count increment that closes
> the cross-CPU race in practice (see below).
>
> Use refcount_inc_not_zero() and continue the list walk on failure,
> matching the other session getters in the file. The ifname getter
> is the only session getter in net/l2tp/ that still uses the bare
> refcount_inc() pattern; this change restores file-internal
> consistency. The success path is unchanged.
>
> Fixes: abe7a1a7d0b6 ("l2tp: improve tunnel/session refcount helpers")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Distro reachability:
>
> l2tp_core and l2tp_netlink autoload via the genl family alias
> net-pf-16-proto-16-family-l2tp on first AF_NETLINK CTRL_CMD_GETFAMILY
> lookup; pppol2tp autoloads on demand via net-l2tp-type-7 from
> L2TP_CMD_SESSION_CREATE with pw_type=L2TP_PWTYPE_PPP. Neither
> autoload requires CAP_SYS_MODULE. SESSION_GET / SESSION_CREATE /
> SESSION_DELETE are GENL_UNS_ADMIN_PERM, so CAP_NET_ADMIN in the
> netns user namespace suffices and is reachable from `unshare -Urn`
> on Debian 11/12, Ubuntu 22.04 LTS / 23.10+ / 24.04+, Arch, Alpine;
> RHEL/Fedora blacklist l2tp_netlink by default but on hosts running
> NetworkManager-l2tp, xl2tpd, or any L2TPv3 endpoint the gate is open
> there too. PREEMPT_RT ships on Ubuntu Pro Realtime, RHEL 9 RT, SUSE
> RT, and Yocto-RT.
>
> Reproduced on x86_64 QEMU/KVM. Under tracefs-kprobe widening at the
> refcount-inc instruction, a PREEMPT_RT build hits "refcount_t:
> addition on 0; use-after-free" through l2tp_session_get_by_ifname at
> 533 s; patched runs 1800 s clean. A stock PREEMPT (non-RT) build
> with the same widening ran 1800 s without firing: local_bh_disable()
> on non-RT prevents preemption inside the RCU section so the
> cross-CPU window does not open at observable rates.
>
>   net/l2tp/l2tp_core.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 1455f67e01ddb..0000000000000 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -441,12 +441,13 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
>   	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
>   		if (tunnel) {
>   			list_for_each_entry_rcu(session, &tunnel->session_list, list) {
> -				if (!strcmp(session->ifname, ifname)) {
> -					refcount_inc(&session->ref_count);
> -					rcu_read_unlock_bh();
> +				if (strcmp(session->ifname, ifname))
> +					continue;
> +				if (!refcount_inc_not_zero(&session->ref_count))
> +					continue;
> +				rcu_read_unlock_bh();
>
> -					return session;
> -				}
> +				return session;
>   			}
>   		}
>   	}
> --
> 2.46.0
>
Reviewed-by: James Chapman <jchapman@katalix.com>



