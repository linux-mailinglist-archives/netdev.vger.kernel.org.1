Return-Path: <netdev+bounces-266244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KbdG6pKsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:45:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA518255069
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4880830EAD28
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964123C871D;
	Tue, 10 Mar 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ294Nxe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZ4gae22"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7F3C943D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160730; cv=none; b=N+tFCvqavTQMYsbbPglJnQUcLmtUMrszo0hRtnElz+519Tv7Szaucqynh+/73YTaOJT7Ajv0LA2nsOkwslx/kjWJ4Mx7srSr5xmqPKiqYBtg0Hl7XYeY6et4uGLfS2Ja3qim8A+nQLrku0i9/+RTJd0jCyUIroPKBwRF8AnH7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160730; c=relaxed/simple;
	bh=J8Z3AFoLCDAmUNsZx32EA5q0NGLL738C6UZv0sQo2jc=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=ugaCJn1l7RmqlgdO9HFEA+kT/PjHK8bzGKMh3Qqbr76ZkdfTa+LmTfqkNNCuyfzP6BYyulWCIizU8WcC+F80HBTj/RSUu6IujZnqe+IneQMURibG1d6fEndaAlk6JF2ZF1stqWwWZxdKTKUmVQ014AaV+6gA2UgQErkpjO2peQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZ294Nxe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZ4gae22; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773160724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTrJyIjkoDHL73Ra6N52gMw3KMNNm3Z3PiE+LotOIBs=;
	b=IZ294NxezRm742n7c7UqWTv9zsldZGWZCaQBDeMtMYASEK8Ar8BKkgjega8sjSIoE4rfO+
	HenWKD5tjfJu6KSVWrsCWTYNk+nKm7Suf0J0OgRPX0aAz5aKqtT5AKz4wnl4ymr8k7JtRp
	ZxG7JCgIhKWI98J5wXHZPb2wxbVtAlk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-2INuhewEMqyuWcu7NEA7Dg-1; Tue, 10 Mar 2026 12:38:42 -0400
X-MC-Unique: 2INuhewEMqyuWcu7NEA7Dg-1
X-Mimecast-MFC-AGG-ID: 2INuhewEMqyuWcu7NEA7Dg_1773160721
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439c794ec8eso7390449f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773160721; x=1773765521; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTrJyIjkoDHL73Ra6N52gMw3KMNNm3Z3PiE+LotOIBs=;
        b=cZ4gae22OdRU+AdXKcX2YUbZtmw5CFfZyvtN0rxf0SjobOH5MQoGz2xm35aCK8n5Zo
         ErqmX8hIUFAk8nd8lMH6Rs2N3pcy4frFEZV88YYj6g7rmVXt/N7c+wvRQ4xbtgyR3jkn
         CsMB/dzvtbpAUIe/ERwzRUfE/s8NE/byT1K9rDDwsi+6cgQXd/i8ha/ukkgn9vSiaw22
         OggwfIkG3nESSwaBVhMyRk3fhgiL9JJbnnCLq8a4JdqMSmMOcHcQ5YfDfyIu6ce4Pj78
         W/wHJYZo8UWNLTQT9dHRiR4fdCPJ65w53Krzqx5r76FHrRosIaGQ9MwJSZqwblgHSFZT
         RUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773160721; x=1773765521;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTrJyIjkoDHL73Ra6N52gMw3KMNNm3Z3PiE+LotOIBs=;
        b=O9fB4xLYh/4sjmHzhpNli6TIhEeAJe01zxGgB4GNFVy7jvFXgSEfheQhPpRtRnMHno
         kCWFDQ67+lz2iqt4Y0PHiRHuqURQZc1gywgdK09+ShN3A6sXjBc+aTqXSnQrHxpaVU4I
         vWy++VGPtRRLCPiSM+pJZpiAT60BhB+XPti7U4Uiqq3FeVWa1JL2DNez6FifI8zC9p0e
         X23F44R2eytXR57l4WkmZy4NTwq37wQOiuqIJKWxvrfTvOJQXIWm4kjZMmw4Ofc+o06G
         KwKFRiis/80aJkFBSn0QLKj63wh7ekwyNptHMSZOLA2LntdnXhxtZ1+JLxVh6hGtafu3
         QrOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1AdAdQnWvJpZeRS+mX6m+dHcHaNKWlYeVljxDkWO5ln6r4K9OzOmBEDS6v659vjeREiG6Cw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SKTtBq5gh34upEprqTmstST027aM0/B8OxqN1Ej/DT8tY+zY
	MEERa2t6LaPUTdVZw2Yyd8MJ4L3HU5ZU+mOiYLhwOV4cvEjdutCtLvYOQkwmgjjYd+fufy53hpb
	BoRRC/Sc0uGkFhJ62RuPkZ5Gz9KeLAwnUAyS4C5irbVWRdPwC3BOlmrAAeA==
X-Gm-Gg: ATEYQzyBkcL3OY6AEFEi2xLLE9OqrMksUPYg8SIbOGQaNS4PGCa+0LWNWbhoyDfRjGZ
	GXgrtuijGzWx3r0C2zs+96g1egIbnghYvnmwaUT4ZYqMWzcn7UkcRAv+Jhl7Qfx2kErGlFLY+5C
	LdnqidG4Dokk1HHJr1DA41+WfdvvwK2iUjOp00vyG7Oxs0Q9kf1GrKtnKkbiL07p2N0MfiPvhwB
	SuYGVow3hGm0pe8Lc+dCapJGsxbUAotffVx8UFSHLeezzGwZ+Lyj3m2OCUGP3R/syAkgFo63LjF
	i4J/WY5+AWCHR2qk2k9FibD8sbpXb98On5ShZTpBTpGFm01Oh7O1iRVuNWD7OSE6JLpqzSXYlR3
	hD599CWvHnd5wJbRjl44m4CAEjBLXTrYMaaKMWTmd3vFll6m84A==
X-Received: by 2002:a05:600c:628d:b0:485:39d6:e305 with SMTP id 5b1f17b1804b1-48539d6e3demr141793935e9.23.1773160721177;
        Tue, 10 Mar 2026 09:38:41 -0700 (PDT)
X-Received: by 2002:a05:600c:628d:b0:485:39d6:e305 with SMTP id 5b1f17b1804b1-48539d6e3demr141793355e9.23.1773160720561;
        Tue, 10 Mar 2026 09:38:40 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm118851155e9.11.2026.03.10.09.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 09:38:40 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>, Ilya Maximets
 <imaximet@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net v4 2/5] selftests: net: run reuseport in an isolated
 netns
Message-ID: <20260310173838.143871a1@elisabeth>
In-Reply-To: <20260309152013.565216-3-aleksey.oladko@virtuozzo.com>
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
	<20260309152013.565216-3-aleksey.oladko@virtuozzo.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Mar 2026 17:38:39 +0100 (CET)
X-Rspamd-Queue-Id: CA518255069
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266244-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[passt.top:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,virtuozzo.com:email]
X-Rspamd-Action: no action

Sorry for the late review, just one hint here (no changes requested):

On Mon,  9 Mar 2026 15:20:10 +0000
Aleksei Oladko <aleksey.oladko@virtuozzo.com> wrote:

> The reuseport_* tests (bpf, bpf_cpu, bpf_numa, dualstack) currently use
> a fixed port range. This can cause intermittent test failures when the
> ports are already in use by other services:
> 
>   failed to bind receive socket: Address already in use
> 
> To avoid conflicts, run these tests in separate network namespaces using
> unshare. Each test now has its own isolated network stack, preventing
> port collisions with the host services.
> 
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
> ---
>  tools/testing/selftests/net/reuseport_bpf.c       | 11 +++++++++++
>  tools/testing/selftests/net/reuseport_bpf_cpu.c   | 10 ++++++++++
>  tools/testing/selftests/net/reuseport_bpf_numa.c  | 10 ++++++++++
>  tools/testing/selftests/net/reuseport_dualstack.c | 11 +++++++++++
>  4 files changed, 42 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/reuseport_bpf.c b/tools/testing/selftests/net/reuseport_bpf.c
> index b6634d6da3d6..12e48b97b862 100644
> --- a/tools/testing/selftests/net/reuseport_bpf.c
> +++ b/tools/testing/selftests/net/reuseport_bpf.c
> @@ -23,6 +23,7 @@
>  #include <sys/socket.h>
>  #include <sys/resource.h>
>  #include <unistd.h>
> +#include <sched.h>
>  
>  #include "kselftest.h"
>  
> @@ -455,8 +456,18 @@ static __attribute__((destructor)) void main_dtor(void)
>  	setrlimit(RLIMIT_MEMLOCK, &rlim_old);
>  }
>  
> +static void setup_netns(void)
> +{
> +	if (unshare(CLONE_NEWNET))
> +		error(1, errno, "failed to unshare netns");
> +	if (system("ip link set lo up"))
> +		error(1, 0, "failed to bring up lo interface in netns");

I don't have much against this approach, except that it needs root /
UID 0 (but these are BPF tests anyway, and that was also the case for
3/5 before), and that it's a bit ugly to invoke ip-link like that.

Anyway, should you or somebody else ever need a snippet that does this
as unprivileged user (giving CLONE_NEWUSER at the same time) and without
external tools or libraries, I made this a while ago:

  https://archives.passt.top/passt-dev/20231206160808.3d312733@elisabeth/

It detaches the network namespace, brings up 'lo' with a minimalistic
netlink implementation, and lets you do whatever you need there.

I guess ideally it could live under selftests/net/lib/ and be used from
C programs or as stand-alone tool for shell scripts as well.

I don't see myself polishing things up and proposing that in the
foreseeable future, but I thought maybe you're interested in it.

> +}
> +
>  int main(void)
>  {
> +	setup_netns();
> +
>  	fprintf(stderr, "---- IPv4 UDP ----\n");
>  	/* NOTE: UDP socket lookups traverse a different code path when there
>  	 * are > 10 sockets in a group.  Run the bpf test through both paths.
> diff --git a/tools/testing/selftests/net/reuseport_bpf_cpu.c b/tools/testing/selftests/net/reuseport_bpf_cpu.c
> index 2d646174729f..ddfe92f6597a 100644
> --- a/tools/testing/selftests/net/reuseport_bpf_cpu.c
> +++ b/tools/testing/selftests/net/reuseport_bpf_cpu.c
> @@ -228,10 +228,20 @@ static void test(int *rcv_fd, int len, int family, int proto)
>  		close(rcv_fd[cpu]);
>  }
>  
> +static void setup_netns(void)
> +{
> +	if (unshare(CLONE_NEWNET))
> +		error(1, errno, "failed to unshare netns");
> +	if (system("ip link set lo up"))
> +		error(1, 0, "failed to bring up lo interface in netns");
> +}
> +
>  int main(void)
>  {
>  	int *rcv_fd, cpus;
>  
> +	setup_netns();
> +
>  	cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  	if (cpus <= 0)
>  		error(1, errno, "failed counting cpus");
> diff --git a/tools/testing/selftests/net/reuseport_bpf_numa.c b/tools/testing/selftests/net/reuseport_bpf_numa.c
> index 2ffd957ffb15..8ec52fc5ef41 100644
> --- a/tools/testing/selftests/net/reuseport_bpf_numa.c
> +++ b/tools/testing/selftests/net/reuseport_bpf_numa.c
> @@ -230,10 +230,20 @@ static void test(int *rcv_fd, int len, int family, int proto)
>  		close(rcv_fd[node]);
>  }
>  
> +static void setup_netns(void)
> +{
> +	if (unshare(CLONE_NEWNET))
> +		error(1, errno, "failed to unshare netns");
> +	if (system("ip link set lo up"))
> +		error(1, 0, "failed to bring up lo interface in netns");
> +}
> +
>  int main(void)
>  {
>  	int *rcv_fd, nodes;
>  
> +	setup_netns();
> +
>  	if (numa_available() < 0)
>  		ksft_exit_skip("no numa api support\n");
>  
> diff --git a/tools/testing/selftests/net/reuseport_dualstack.c b/tools/testing/selftests/net/reuseport_dualstack.c
> index fb7a59ed759e..0eaf739d0c85 100644
> --- a/tools/testing/selftests/net/reuseport_dualstack.c
> +++ b/tools/testing/selftests/net/reuseport_dualstack.c
> @@ -25,6 +25,7 @@
>  #include <sys/types.h>
>  #include <sys/socket.h>
>  #include <unistd.h>
> +#include <sched.h>
>  
>  static const int PORT = 8888;
>  
> @@ -156,10 +157,20 @@ static void test(int *rcv_fds, int count, int proto)
>  	close(epfd);
>  }
>  
> +static void setup_netns(void)
> +{
> +	if (unshare(CLONE_NEWNET))
> +		error(1, errno, "failed to unshare netns");
> +	if (system("ip link set lo up"))
> +		error(1, 0, "failed to bring up lo interface in netns");
> +}
> +
>  int main(void)
>  {
>  	int rcv_fds[32], i;
>  
> +	setup_netns();
> +
>  	fprintf(stderr, "---- UDP IPv4 created before IPv6 ----\n");
>  	build_rcv_fd(AF_INET, SOCK_DGRAM, rcv_fds, 5);
>  	build_rcv_fd(AF_INET6, SOCK_DGRAM, &(rcv_fds[5]), 5);

-- 
Stefano


