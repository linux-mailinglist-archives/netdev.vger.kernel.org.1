Return-Path: <netdev+bounces-277000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOnOBNak12mJQwgAu9opvQ
	(envelope-from <netdev+bounces-277000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:08:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FDD3CACE5
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD4B6300CC9A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE283CEBB6;
	Thu,  9 Apr 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHrGHXUo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620703BFE26;
	Thu,  9 Apr 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775739941; cv=none; b=GdsDjx2KszBdIWuNlrWGenRoTDNcPLkAGRG1RrusWYBh132Yv/V56r8oRevzEUIXkSW1zH0QbcARcOiT0AJkc7PxXVpY9i9YlT012Buo0MVMqPSgsU2D7RXecMGmN+Dzw/bGjmUuk2XWymscOqYiRRXH4dAqpMdfxIt2EMxRdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775739941; c=relaxed/simple;
	bh=J0s6O4DpU42FeihdRs7hFM5/jocnnBLeGwX2SLhu0Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcnlKDR6JFJKd8LA9G7Uu4Ne29W1XAM6QJbAeEcBRlc3uUUPUWIFQaxOAsI2xnUHtYO1rECroWTdxJyusV77fiCPe1fXAExFjF7bYUsIYjTQNdPgmprtNKngpfuIG9xpki+RYBMN+J3Kdc44wT5v8x8iSCPp+tWREf6yawTb39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHrGHXUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E3EC4CEF7;
	Thu,  9 Apr 2026 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775739941;
	bh=J0s6O4DpU42FeihdRs7hFM5/jocnnBLeGwX2SLhu0Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHrGHXUof5Do4EsuKLEJ5AIBTWZfJjLC2Le0XzIY/5ubmFBVD+umqmi2M/C/NoKiK
	 f+WrWhRWbw+R10z06ZGno/dnMGejWropuaiVQWnV8PJbF3SaD+Pxnm3MhJhZklEX7G
	 d7e84q4wDXAgEuLm8Efw916uAl9F0lOen07kte2ewTLAX2NuvTzLWHlmjbS6io850b
	 D8i+Kc0GecoJxEcWB5xHkA0N62brmErvqmyfDnunHMph1wcZHfy9ZU9hhTRs0Uae8a
	 WRA++gcYGs4ZKDxWWZExYiPsBWe1Ah9K4HKHofIcQv7vr+jBai7LSaHpRzbr/azC2q
	 HDK2Kmcod5wFQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Michal Luczaj <mhal@rbox.co>,
	David Wei <dw@davidwei.uk>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Xin Long <lucien.xin@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 0/5] uaccess/sockptr: copy_struct_ fixes and more helpers
Date: Thu,  9 Apr 2026 15:05:06 +0200
Message-ID: <20260409-lehnstuhl-zerkratzen-549c8e1d376f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775576651.git.metze@samba.org>
References: <cover.1775576651.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=brauner@kernel.org; h=from:subject:message-id; bh=J0s6O4DpU42FeihdRs7hFM5/jocnnBLeGwX2SLhu0Uo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReXyJUlXBq6dyyzx4sx5M2FfyecPn50xuLd0xbzbsh+ U9V4PyNNh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT0fJg+O972//WnrNtt6vZ C+s3+NnVC607vJeze66xhHzwpc452asYGS7yLTydfEtwlZAIV2n2vULd0+v7I3880qvn86l7IfF WnBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277000-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arista.com,davemloft.net,rbox.co,davidwei.uk,intel.com,holtmann.org,google.com,redhat.com,cyphar.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 77FDD3CACE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 07 Apr 2026 18:03:12 +0200, Stefan Metzmacher wrote:
> here are some patches related to
> copy_struct_{from,to}_{user,sockptr}()
> I collected during my work on an IPPROTO_SMBDIRECT
> implementation wrapping the smbdirect code used
> by cifs.ko and ksmbd.ko.
> 
> The first patch fixes copy_struct_to_user()
> to behave like documented.
> 
> [...]

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/5] uaccess: fix ignored_trailing logic in copy_struct_to_user()
      https://git.kernel.org/vfs/vfs/c/0a8d67b47a5c
[2/5] sockptr: fix usize check in copy_struct_from_sockptr() for user pointers
      https://git.kernel.org/vfs/vfs/c/e555ebefea0a
[3/5] uaccess: add copy_struct_{from,to}_bounce_buffer() helpers
      https://git.kernel.org/vfs/vfs/c/14e710721cd3
[4/5] sockptr: let copy_struct_from_sockptr() use copy_struct_from_bounce_buffer()
      https://git.kernel.org/vfs/vfs/c/62343ea38031
[5/5] sockptr: introduce copy_struct_to_sockptr()
      https://git.kernel.org/vfs/vfs/c/9899f22cc41d

