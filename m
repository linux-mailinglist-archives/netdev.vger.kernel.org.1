Return-Path: <netdev+bounces-305646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5ziHBzDoTWq5/wEAu9opvQ
	(envelope-from <netdev+bounces-305646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 08:03:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B361E7220C5
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 08:03:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=m8uQUtJJ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305646-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305646-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D9A3300B9F8
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D04346E4C;
	Wed,  8 Jul 2026 06:03:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA571C84BC
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 06:03:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490604; cv=none; b=TbDAyRt5SRqsmu1ib5Xz5rN1H1fXXHJAC/WhUqGMJZnlhv6ouLYKu9UoqMFn8s+egTKgukNjDVe5dlz4bgPGXepEhHZfpZdQ7f5Hdh/9R2hSEklSgwV0484Ghsex6UusjwVnKi1qTVAkJbO+CZpBZQKx4rdgAxngvrVPMStw7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490604; c=relaxed/simple;
	bh=G+Zy+50sswLqvxHTxmLmEceB0TfwARABKNafZj9wW90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZMworjblQGpkQM5APdhcENeauxeXQi2HtTmxmBNwlvd7vmC7JycuEqdxyXloVztRk1HrMV8NT12iBZcMRW2XRICv2KUSKOtjGNvg/g1M0I3/J9x5GFI2HJzxrlZYAz6eNxdcK1R0wD15MRaqPS2V5YPD9USZ98yfaLvhc/h9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8uQUtJJ; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476a130c138so305496f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 23:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783490602; x=1784095402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dwy+RDOzAL2FX2yB6Z3gGvj+yaTV4lhwZVHU/RKj4o4=;
        b=m8uQUtJJshx7+qOFZ3+MzjXdh14uzxQuQS9FF7GW9qqUkbZ3tZHYP1CgBtsD1sW9dM
         akcDQY29TIVWfMmSCxxCVlVeUaKc+bS7gLGlKUkdwDmPZ4ffNmucKzm+dS2EKTvVqNNi
         eEDUPA2GiCgJeS2+teibLRMRqUSZ0r/3+dSKW9Z51tkUYJhMpNH0SRg4yCuyKVFRfahZ
         uCOWkAKpMwN2D9TFlynZCsAzKSRqUakBL8fsRBP6e7CbRD4BnTv7H3ZadALS/LtDf3zL
         BUktoizudb1mfeabiTTxdyr6WzV5byrkXZ/mX730MlPwF7f53vwdnQ2vQ+p+8fMUtxzs
         NBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783490602; x=1784095402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dwy+RDOzAL2FX2yB6Z3gGvj+yaTV4lhwZVHU/RKj4o4=;
        b=Jg34MmDJArjX9jYZtVz7RfO7JpcaZdb6cStQ9ucctLNqAeqn0BHPznzVqDWOXPLFdT
         11vOcFhLbXN1BECs7tGOedmHZZ3gNOwrbzgcBN3WFkmbJ1GW6UARla7BYABbenP/XPqk
         XmGW448TCjT0gO6ubZGDTiKRhdaT7eXBiGHtiAN0CBj0EhhCT0x1+v6jre0HtkKjlrxq
         U3Y3mmh29z6WyJmRV7gQ6GJxYXWKluHqm4S0YjpjifWgzO0v9cI1M0KyERZ52me4amYS
         1w1usTuDBderPOieb9dYYaM55rKFI4rUOs0GJESZt/Y+WRnKWjNIEIgTB+3l0EO2Lp30
         UbJg==
X-Forwarded-Encrypted: i=1; AHgh+RoBceqp8BViNWYkuv2kDKEx8ammRoaglxlmfAhAt3SeY2OdcixBTXJPHhCgm/MNCBuhPRQXC90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8obPs2eDsOoRh5qo3q4Kxz+4XqLov0MnJScicrWQAQQbND3JS
	duYDwcz6882C1WFIbsLTOlUf9TVxf5F55rYOU+bfqNX8qmUs9G3e+/tx
X-Gm-Gg: AfdE7cnC8HRSX1V13MFJR1XhLBiUXbWeSvLm5temSwVdL9KetHn8KhpR11LA9wuOIaG
	AbL7Y28YzXZuGPkdwUWiMkbKVBxO8wXoma6T9WHFs2s2EfqH0uX6CDnBsM4GbPKKQy/326zC740
	4q0/CVKe6tpVXqifww/9tIbAXV9NLaTYedBHmbmC49WlgmS62IJc0PtW4msVgfy3IKuyjNkRaEH
	DRYUqqx0lVNDVAIz2xKD8gbhVg6VR/1H41OJchwQeTTAk08W50VNbu7LlR35qWIFqAE4NZlQpUc
	Y2qeqwoxQp+7WFKtTOgzhWsm+eAwt8LvNjajL1EeMSZkBcESlm5uEi8HFg9U3RP1K3a4eN+CjVf
	/hg9Tsn2gGSGtTc68k0JpodmbxjjMpj1MS9xv+9c+qXCiWhrBys1uxrrYjM0WrD6gLPHZ59mvNm
	qt1QgD3j+ZkKHqXnx+fnqRAXt7d7qyJaX5asxnGFLnVL868+rj
X-Received: by 2002:a05:6000:1a86:b0:47d:e0da:fe71 with SMTP id ffacd0b85a97d-47df07149b6mr849702f8f.7.1783490601395;
        Tue, 07 Jul 2026 23:03:21 -0700 (PDT)
Received: from localhost.localdomain ([151.189.113.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6da9sm38923146f8f.12.2026.07.07.23.03.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 23:03:20 -0700 (PDT)
From: Nils Juenemann <nils.juenemann@gmail.com>
To: rjethwani@everpuredata.com
Cc: borisp@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	nils.juenemann@gmail.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	sd@queasysnail.net,
	tariqt@nvidia.com
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
Date: Wed,  8 Jul 2026 08:03:19 +0200
Message-ID: <20260708060319.68063-1-nils.juenemann@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAKaoeS3RbLP=D1G6HHaSfQLj4VSi_W=HZ9EnKxKia_EjcT1vSw@mail.gmail.com>
References: <CAKaoeS3RbLP=D1G6HHaSfQLj4VSi_W=HZ9EnKxKia_EjcT1vSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305646-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rjethwani@everpuredata.com,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:nils.juenemann@gmail.com,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:johnfastabend@gmail.com,m:nilsjuenemann@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B361E7220C5

On Tue, Jul 7, 2026 at 5:31 PM Rishikesh Jethwani <rjethwani@everpuredata.com> wrote:
>
> Could you post the disassembly [...] count how many distinct loads of
> sk+0x4f8 the compiler emitted in that region.

objdump of mlx5e_ktls_handle_rx_skb, CQE_TLS_OFFLOAD_RESYNC branch
(+0x63) through RIP+0x10a; bytes match the oops Code around the fault:

  11bd03:	48 83 82 90 01 00 00 	addq   $0x1,0x190(%rdx)
  11bd0a:	01
  11bd0b:	48 8b b6 d0 00 00 00 	mov    0xd0(%rsi),%rsi
  11bd12:	49 89 fc             	mov    %rdi,%r12
  11bd15:	4c 8b b7 00 01 00 00 	mov    0x100(%rdi),%r14
  11bd1c:	0f b7 46 0c          	movzwl 0xc(%rsi),%eax
  11bd20:	4d 8b be 08 01 00 00 	mov    0x108(%r14),%r15
  11bd27:	66 3d 81 00          	cmp    $0x81,%ax
  11bd2b:	0f 84 a4 01 00 00    	je     11bed5 <mlx5e_ktls_handle_rx_skb+0x235>
  11bd31:	66 3d 88 a8          	cmp    $0xa888,%ax
  11bd35:	0f 84 9a 01 00 00    	je     11bed5 <mlx5e_ktls_handle_rx_skb+0x235>
  11bd3b:	0f b7 43 78          	movzwl 0x78(%rbx),%eax
  11bd3f:	49 89 c5             	mov    %rax,%r13
  11bd42:	48 01 c6             	add    %rax,%rsi
  11bd45:	45 8b 8e e0 00 00 00 	mov    0xe0(%r14),%r9d
  11bd4c:	0f b6 06             	movzbl (%rsi),%eax
  11bd4f:	83 e0 f0             	and    $0xfffffff0,%eax
  11bd52:	3c 40                	cmp    $0x40,%al
  11bd54:	0f 84 a8 01 00 00    	je     11bf02 <mlx5e_ktls_handle_rx_skb+0x262>
  11bd5a:	44 0f b7 46 2a       	movzwl 0x2a(%rsi),%r8d
  11bd5f:	41 8d 45 28          	lea    0x28(%r13),%eax
  11bd63:	0f b7 56 28          	movzwl 0x28(%rsi),%edx
  11bd67:	4c 89 ff             	mov    %r15,%rdi
  11bd6a:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  11bd6d:	48 8d 4e 18          	lea    0x18(%rsi),%rcx
  11bd71:	4c 8d 76 28          	lea    0x28(%rsi),%r14
  11bd75:	48 83 c6 08          	add    $0x8,%rsi
  11bd79:	6a 00                	push   $0x0
  11bd7b:	66 41 c1 c0 08       	rol    $0x8,%r8w
  11bd80:	45 0f b7 c0          	movzwl %r8w,%r8d
  11bd84:	e8 00 00 00 00       	call   11bd89 <mlx5e_ktls_handle_rx_skb+0xe9>
  11bd89:	49 89 c7             	mov    %rax,%r15
  11bd8c:	58                   	pop    %rax
  11bd8d:	4d 85 ff             	test   %r15,%r15
  11bd90:	0f 84 4a ff ff ff    	je     11bce0 <mlx5e_ktls_handle_rx_skb+0x40>
  11bd96:	41 0f b6 47 12       	movzbl 0x12(%r15),%eax
  11bd9b:	3c 06                	cmp    $0x6,%al
  11bd9d:	0f 84 cc 00 00 00    	je     11be6f <mlx5e_ktls_handle_rx_skb+0x1cf>
  11bda3:	49 8b 87 f8 04 00 00 	mov    0x4f8(%r15),%rax
  11bdaa:	48 8b 40 30          	mov    0x30(%rax),%rax

One load of sk+0x4f8 in this range, at 11bda3 (the fault). r15 only
becomes sk at 11bd89 (mov %rax,%r15), so there is no sk+0x4f8
dereference before 11bda3 in this range. The only other sk+0x4f8
load in the function is 11be20, after the fault and not reached. So my
earlier "two independent loads, second reading NULL" was wrong.

Thanks,
Nils

