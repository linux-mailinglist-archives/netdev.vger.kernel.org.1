Return-Path: <netdev+bounces-297866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ppo9KAz5KWqZgQMAu9opvQ
	(envelope-from <netdev+bounces-297866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:53:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCE866D731
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:53:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aUf5dfKb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297866-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297866-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1172730285D9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033CF3AB5DA;
	Wed, 10 Jun 2026 23:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B96331EC7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:53:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135624; cv=none; b=hdhSfiTbjLKdnBq8JNJ4OcrRGzGaLdzGycBV/NYOEm5plFHk+/xj0KYmFFZzoJDB42+Ur7wOoCnFkNm8VRjXJv3JQoJRUQR5yYvcKMsEXp8wwQIC9MO+zrOiAf+3dJn8J2RbaPsQCZTflZ8PSDeBXpOblTqHlF77jxrb5vaMnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135624; c=relaxed/simple;
	bh=prLHLsl4bj565w0qf8Skz+Ef3R8wGxY4mncR3a8blzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrhV37xhVzezj1oyDQmpTRQUD9VvOvr5PDZ2o+AjF/oGkzlk5qyhVy1WWJNWyF3vRW442AlmD6GCgodghI4Ey4wVCvg4/uMgTS+we/iZTzaswFWHvTU2eKB8vfhwewAUspBXedDl+mW81NCm9Dnj088ER3EuKxU+ZP2q8jOJIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUf5dfKb; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c2d792c8so49200725ad.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781135623; x=1781740423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8+UXwF2OPvYezHQZAdNauCtv8sKpiJQm57EsjDosSQ=;
        b=aUf5dfKbw0ir5+9VC52hf1OWNGpa3plLSQkg50flFNFAyB3cd2S+NjhIJkFmg8QaEU
         ShC4eHM7IlvBnnldBHmxZhj7rXt19J0WYsbb1kerOYDM233Wovnyl6n3uN17sPG+VWBx
         QFa2uB50jACa1Aj17Bo/mErp1X1jX6FKuvPZ95kn4KZ1uK5GTfhjK0fePmyJHTnBslI4
         UVJSX5epAIyEqxbWSnRM8IVac2T7Ahg+1Ps68+FYq8Kc6ccNyY5W9LYMlIAYSvOOuTSQ
         aEenW7f/U9V8pLF9M5iJfcEkNaC8SjPxH5qOKohXbmyOjI6HaT6bcyBrl3m86TD864WW
         6TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781135623; x=1781740423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8+UXwF2OPvYezHQZAdNauCtv8sKpiJQm57EsjDosSQ=;
        b=cGAHDLVaqzvgQ8S6/q4zOkiJDzHEpsAFNJQaW4ysvHEJMpqBgdklQu8NkkQbZHDnxw
         fp+8KFHzCrQLMxOYBZ5IT+PyO9gBFPa3yeYjMJp2+l0hpljklOnE61RmGXm2F6+6gkMc
         d4kNtmYQCtmGvkhqhE0JIBWDLatugSfLaonTyOq8As+JJT7nxY1YBKV8Ar8/Qb1k0aAS
         TUecSyJz6SlBI990AUsOFVC6YdHZc9yA1QBjO/AiKPBFFCgfGIyaiQhwrub17FFFdeXD
         FKkaM8Vo9Dq+M1fQtjNm10cKDs5LcyjG2mEbniK7aqIUnDbK5psU/TJOCllo3ZcTDHZ2
         N1xQ==
X-Forwarded-Encrypted: i=1; AFNElJ+L11K9ig1+6x7nelcV3BaT4CuLfnaS6JGIAm1c4ScIJ4VJnuuyZSnp5ROm7eF+OwyFkmGYe3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdzd9z4AkEtzS9Zw1KUL0jRV+Ak52LVgQ/rywV14Qyy/C7A2B
	iRay/T0BCRFIsDZaVxiNkKWUZb17XVuFURoyJhGdvqMY7RlbFdiunGDG
X-Gm-Gg: Acq92OF0lx5jck+lZinwoUfFQ/9GIHONI1lap1tSiZR21nYzl6ZP8VXOVzGI2KUFn2t
	ubxV4dv6+wO9nOXBjTzEnSHKYc4zx9+O7+1AqdvQsQz69InTSr8ZLx6ZcPltMCZj3rDO6bqKYvp
	L/pYCtWCKX7MLpNwebLdbACmK/I/5PZb7edXwbB4g4OMc5i+2xSwcefR1c4inSXHVekHrmWOc9D
	i4/lkyQU4yntISqFACnzZWd/VlYxdQs3t48iEvO9xgDHTumSJdwlD62KfN+vJTFPGxCEwvDIWqe
	aq0G0Db7F1ft2xbEw1PdKNWbbe1rWQ99v7F252bH/ZAzqT2CkF22vvwBMTLsJnnK7zGlDtFConl
	sjjPqesll9nweC4EMmOg2wtvVYasYuhK8TwnXdHeI+/lunWZISScoTt2/56MMM5wDbkjLbsh49i
	Nlf4SvZtX097iO4gAMOmhK9qekCG48JgdGE0ZvS+M+U70n3JvLi10GQgM=
X-Received: by 2002:a17:903:b88:b0:2bd:9803:9308 with SMTP id d9443c01a7336-2c2f3066db0mr2181965ad.36.1781135622845;
        Wed, 10 Jun 2026 16:53:42 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm265220345ad.82.2026.06.10.16.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:53:42 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:53:40 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, bobbyeshleman@meta.com,
	dw@davidwei.uk, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] selftests/net: Use public NetDrvContEnv API
 in nk_qlease fixtures
Message-ID: <ain5BKx4Vupob5al@devvm29614.prn0.facebook.com>
References: <20260610080344.701380-1-daniel@iogearbox.net>
 <20260610080344.701380-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610080344.701380-3-daniel@iogearbox.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297866-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:email,iogearbox.net:email,devvm29614.prn0.facebook.com:mid,netns.name:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FCE866D731

On Wed, Jun 10, 2026 at 10:03:42AM +0200, Daniel Borkmann wrote:
> Expose the netkit host ifname as a public attribute nk_host_ifname
> (symmetric with the already-public nk_guest_ifname), rename _attach_bpf
> to a public attach_bpf, and add a public detach_bpf helper that
> encapsulates the tc-filter teardown bookkeeping. Switch the fixtures
> to this public API. No functional change and keeps pylint happy.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  .../selftests/drivers/net/hw/nk_qlease.py     | 33 ++++++++---------
>  .../selftests/drivers/net/lib/py/env.py       | 36 +++++++++++--------
>  2 files changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/nk_qlease.py b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> index 81125856727f..fee114676fd8 100755
> --- a/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> +++ b/tools/testing/selftests/drivers/net/hw/nk_qlease.py
> @@ -34,16 +34,11 @@ from lib.py import KsftSkipEx, CmdExitFailure
>  
>  
>  def _create_netkit_pair(cfg, rxqueues=2):
> -    if cfg._nk_host_ifname:
> -        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
> -        cfg._nk_host_ifname = None
> +    if cfg.nk_host_ifname:
> +        cmd(f"ip link del dev {cfg.nk_host_ifname}", fail=False)
> +        cfg.nk_host_ifname = None
>          cfg.nk_guest_ifname = None
> -    if getattr(cfg, "_tc_attached", False):
> -        cmd(
> -            f"tc filter del dev {cfg.ifname} ingress pref {cfg._bpf_prog_pref}",
> -            fail=False,
> -        )
> -        cfg._tc_attached = False
> +    cfg.detach_bpf()
>  
>      all_links = ip("-d link show", json=True)
>      old_idxs = {
> @@ -79,17 +74,17 @@ def _create_netkit_pair(cfg, rxqueues=2):
>          raise KsftSkipEx("Failed to create netkit pair")
>  
>      nk_links.sort(key=lambda x: x["ifindex"])
> -    cfg._nk_host_ifname = nk_links[1]["ifname"]
> +    cfg.nk_host_ifname = nk_links[1]["ifname"]
>      cfg.nk_guest_ifname = nk_links[0]["ifname"]
>      cfg.nk_host_ifindex = nk_links[1]["ifindex"]
>      cfg.nk_guest_ifindex = nk_links[0]["ifindex"]
>  
>      ip(f"link set dev {cfg.nk_guest_ifname} netns {cfg.netns.name}")
> -    ip(f"link set dev {cfg._nk_host_ifname} up")
> -    ip(f"-6 addr add fe80::1/64 dev {cfg._nk_host_ifname} nodad")
> +    ip(f"link set dev {cfg.nk_host_ifname} up")
> +    ip(f"-6 addr add fe80::1/64 dev {cfg.nk_host_ifname} nodad")
>      ip(
>          f"-6 route add {cfg.nk_guest_ipv6}/128 via fe80::2 "
> -        f"dev {cfg._nk_host_ifname}"
> +        f"dev {cfg.nk_host_ifname}"
>      )
>      ip(f"link set dev {cfg.nk_guest_ifname} up", ns=cfg.netns)
>      ip(f"-6 addr add fe80::2/64 dev {cfg.nk_guest_ifname}", ns=cfg.netns)
> @@ -102,7 +97,7 @@ def _create_netkit_pair(cfg, rxqueues=2):
>          ns=cfg.netns,
>      )
>  
> -    cfg._attach_bpf()
> +    cfg.attach_bpf()
>  
>  
>  def _setup_lease(cfg, rxqueues=2):
> @@ -135,9 +130,9 @@ def _setup_lease(cfg, rxqueues=2):
>  
>  
>  def _teardown_netkit(cfg):
> -    if cfg._nk_host_ifname:
> -        cmd(f"ip link del dev {cfg._nk_host_ifname}", fail=False)
> -        cfg._nk_host_ifname = None
> +    if cfg.nk_host_ifname:
> +        cmd(f"ip link del dev {cfg.nk_host_ifname}", fail=False)
> +        cfg.nk_host_ifname = None
>          cfg.nk_guest_ifname = None
>  
>  
> @@ -320,9 +315,9 @@ def test_destroy(cfg) -> None:
>      kill_timer = threading.Timer(1, rx_proc.proc.terminate)
>      kill_timer.start()
>  
> -    ip(f"link del dev {cfg._nk_host_ifname}")
> +    ip(f"link del dev {cfg.nk_host_ifname}")
>      kill_timer.join()
> -    cfg._nk_host_ifname = None
> +    cfg.nk_host_ifname = None
>      cfg.nk_guest_ifname = None
>  
>      queue_info = netdevnl.queue_get(
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index 2cc78b8a2152..e1038a02760e 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -341,7 +341,7 @@ class NetDrvContEnv(NetDrvEpEnv):
>                   userns=False, **kwargs):
>          self.netns = None
>          self._userns = userns
> -        self._nk_host_ifname = None
> +        self.nk_host_ifname = None
>          self.nk_guest_ifname = None
>          self._tc_clsact_added = False
>          self._tc_attached = False
> @@ -395,23 +395,23 @@ class NetDrvContEnv(NetDrvEpEnv):
>              raise KsftSkipEx("Failed to create netkit pair")
>  
>          netkit_links.sort(key=lambda x: x['ifindex'])
> -        self._nk_host_ifname = netkit_links[1]['ifname']
> +        self.nk_host_ifname = netkit_links[1]['ifname']
>          self.nk_guest_ifname = netkit_links[0]['ifname']
>          self.nk_host_ifindex = netkit_links[1]['ifindex']
>          self.nk_guest_ifindex = netkit_links[0]['ifindex']
>  
>          self._setup_ns()
> -        self._attach_bpf()
> +        self.attach_bpf()
>          if primary_rx_redirect:
>              self._attach_primary_rx_redirect_bpf()
>  
>      def __del__(self):
>          if self._primary_rx_redirect_attached:
> -            cmd(f"tc filter del dev {self._nk_host_ifname} ingress", fail=False)
> +            cmd(f"tc filter del dev {self.nk_host_ifname} ingress", fail=False)
>              self._primary_rx_redirect_attached = False
>  
>          if self._primary_rx_redirect_clsact_added:
> -            cmd(f"tc qdisc del dev {self._nk_host_ifname} clsact", fail=False)
> +            cmd(f"tc qdisc del dev {self.nk_host_ifname} clsact", fail=False)
>              self._primary_rx_redirect_clsact_added = False
>  
>          if self._tc_attached:
> @@ -427,9 +427,9 @@ class NetDrvContEnv(NetDrvEpEnv):
>                  host=self.remote, fail=False)
>              self._remote_route_added = False
>  
> -        if self._nk_host_ifname:
> -            cmd(f"ip link del dev {self._nk_host_ifname}")
> -            self._nk_host_ifname = None
> +        if self.nk_host_ifname:
> +            cmd(f"ip link del dev {self.nk_host_ifname}")
> +            self.nk_host_ifname = None
>              self.nk_guest_ifname = None
>  
>          if self._init_ns_attached:
> @@ -470,9 +470,9 @@ class NetDrvContEnv(NetDrvEpEnv):
>          self._init_ns_attached = True
>          ip("netns set init 0", ns=self.netns)
>          ip(f"link set dev {self.nk_guest_ifname} netns {self.netns.name}")
> -        ip(f"link set dev {self._nk_host_ifname} up")
> -        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
> -        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
> +        ip(f"link set dev {self.nk_host_ifname} up")
> +        ip(f"-6 addr add fe80::1/64 dev {self.nk_host_ifname} nodad")
> +        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self.nk_host_ifname}")
>  
>          ip("link set lo up", ns=self.netns)
>          ip(f"link set dev {self.nk_guest_ifname} up", ns=self.netns)
> @@ -512,7 +512,13 @@ class NetDrvContEnv(NetDrvEpEnv):
>                  return map_id
>          raise Exception(f"Failed to find .bss map for prog {prog_id}")
>  
> -    def _attach_bpf(self):
> +    def detach_bpf(self):
> +        if self._tc_attached:
> +            cmd(f"tc filter del dev {self.ifname} ingress pref "
> +                f"{self._bpf_prog_pref}", fail=False)
> +            self._tc_attached = False
> +
> +    def attach_bpf(self):
>          bpf_obj = self.test_dir / "nk_forward.bpf.o"
>          if not bpf_obj.exists():
>              raise KsftSkipEx("BPF prog not found")
> @@ -539,9 +545,9 @@ class NetDrvContEnv(NetDrvEpEnv):
>          if not bpf_obj.exists():
>              raise KsftSkipEx("Primary RX redirect BPF prog not found")
>  
> -        if self._tc_ensure_clsact(self._nk_host_ifname):
> +        if self._tc_ensure_clsact(self.nk_host_ifname):
>              self._primary_rx_redirect_clsact_added = True
> -        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
> +        cmd(f"tc filter add dev {self.nk_host_ifname} ingress"
>              f" bpf obj {bpf_obj} sec tc/ingress direct-action")
>          self._primary_rx_redirect_attached = True
>  
> @@ -550,7 +556,7 @@ class NetDrvContEnv(NetDrvEpEnv):
>          self._remote_route_added = True
>  
>          filters = json.loads(
> -            cmd(f"tc -j filter show dev {self._nk_host_ifname} ingress").stdout)
> +            cmd(f"tc -j filter show dev {self.nk_host_ifname} ingress").stdout)
>          redirect_prog_id = None
>          for bpf in filters:
>              if 'options' not in bpf:
> -- 
> 2.43.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

