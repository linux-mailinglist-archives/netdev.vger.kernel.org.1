Return-Path: <netdev+bounces-299624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O4cHJRxuMGrpSwUAu9opvQ
	(envelope-from <netdev+bounces-299624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:26:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24E68A291
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:26:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=wJcJ19BU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299624-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299624-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4595F3011065
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A703AC0DE;
	Mon, 15 Jun 2026 21:26:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE23A9630
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 21:26:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558807; cv=pass; b=puXfWjArClHsTQLy6TMF4c0MeeQw6TWYfHMb5JrTRRun+btL6ABFSyJOetRJM1L/wcCCGj74eW9B19qD5vdiIW7+h+SlxdKMyR8yspztUU8cyqKSQnL7bZgeaLzB8DguFB6XMG1GB24GOTPqDbzMoxMwsy/0BE2zaG/4rYeMAlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558807; c=relaxed/simple;
	bh=ToZuC56F4bCiUTbRp3OuxSWwbRuPhht31/r/OtwBpF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmBch2o3HRSZIjflWEUwR07UtJDEaxI6CoaJ3oHb1x0AunOdHb+4SpebRriGGupkXjDlGlMuHHURKKBwfH7oIakkwXC9oagUZpsIwW3QhWV4RlyO7n4Bvixu+2C5Ud3KeSprC95pIZ6R+0siuymTKc/AAWr8ZjMXW8PGDrmC5hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJcJ19BU; arc=pass smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so1605a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781558804; cv=none;
        d=google.com; s=arc-20240605;
        b=MBFWFa63AjUzTu+BEjv3qCZGG7Ysz/QJj9SNC9W3gQx2bLVkIXRpG9wDg74bRpLgKs
         WLEou+XEpsRXrDmUbpTfvwAZFo1kNrWGaYFiwRMdne3hdHM1Kht4zqiGxBKn3x2+C6I5
         MPsQQ5YJw4ZSLkVnD92auPaney1HTsRheD6x2AH7GbqfzrEFojYbqbE3nPs4m+QZUErO
         nMuKVX8T+O6HtOfoE04QhKLYXesNLsNc7JXGGy7pJxPnswM0TEkgiXdo8y0ATq9tYmpP
         /oghSrrPkgLQVyu/6wYdV3g0pqcYjGnATPTbou7/vXHRtndxj88A5MTX2tOcxqQ/AMZB
         hQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ToZuC56F4bCiUTbRp3OuxSWwbRuPhht31/r/OtwBpF4=;
        fh=CuFjYcRKeIGLYHgKT0rLB2/0/jZqMLZ1ao2mb6DA+pM=;
        b=gUPdO3Xg80Rp3O+TAuZTyNgx8DTDNUJc7Y7RDzuLvVDz8+M/JpR9Z87cSRVqvo618d
         n+mjLH6mAddN7Q3JutCfJNq07GR44Cwe0Ic7dnvKbKvk23sNmGnT1EApQ24vCYL39Xhc
         ZbBaUzXTHg4NVAy/T7M/Mc13qZP6Bue+2uvKdORKsMBaF7Dp193G873Yr2+FM0EHqytO
         8Zf5sWcgl6v3hv5wFy7V+KAIdd7CdR/rDmVq1Qesg7nGbWrivnMXLmC78RCoUe4Wi2PG
         AJ51gxziJeffBqUs17vj6g/DUvMteLSUQ6wJaOfU4KiAWw5dzQV4RFmnOeu6CMJnNzWy
         XjHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781558804; x=1782163604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ToZuC56F4bCiUTbRp3OuxSWwbRuPhht31/r/OtwBpF4=;
        b=wJcJ19BUqwtou1Sk1rnbjjN+omDm/Wry4F4yQ86yVGBW7uYgsN456KG/NId0Eb2igT
         7IWyfCP3/FSIYKbLeyG0Vq/ccDfyK3r7TlmLrtOcCM0+MZzBKfhP6co4ucC+MC9KZ7eM
         /BSieVWBjLoIjZImD9VaF3z1LiGTW+Z9Hc0vADu0d7M2BjCCJrEMjbW15mHsfnrpX2R9
         82tdxwT0jpb0kPLpqlwBYUIUu1kGiVDzDZOySZVU1I3jq5zs1DhlhCS+9xgSIjRJdB0j
         ZRm4MTfFjS7G/fLZbzpi/JK7Z52qQmSTsat3iJVYJFNrYWyv67/OGnrmgYmJqSZulgbU
         jirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781558804; x=1782163604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToZuC56F4bCiUTbRp3OuxSWwbRuPhht31/r/OtwBpF4=;
        b=cY94Bi+1SWD7ik+3o/LzCzKYDpvNpoBF2CZj0FAPlqbil4qspzSa28u5jG5E+m+8dN
         fsEroovbn7/dzgbGm0cj1XG1a0TC+sdQ4ucOIs11DrFA1XCmGDRYkvn1VzXSx3xqMgyW
         PBa4w7AwZwcn2JA8yBI/aKuoCFHCORtDcPBShRcBm7mMAv/lOMVSetJdTUFDV9Bh+te/
         SR8kzCFU6+ByYymG+xGbxB8GJivDcpBvJtmiMGfImxmUf1bu0VJZQTQU3r2uNMb/Lp2B
         nl5/UTP5L+mPf3qTJpJOO0C9AkUq4I/+dh8HmSSgJbewye8GHKDDoFEd5Dty6XV9WpGy
         w+7w==
X-Forwarded-Encrypted: i=1; AFNElJ+FdhVpHalCIGd7iNqbukaKJufYKHou5HiPjbaj9l/HfEVHI/lIdbR+QS0EYrZMiMR7Wfg8zIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Dul6qB1myLJfHIIKIFUpBQvLrNdzsPL24j3LoS+9gGZkbIHE
	i4fN0kYTrVe9T2BzXNAD4TnJYkMmt1eWhOdMTdexVntJWdiPJqrul36gO5TfmlSSVHAyNhhOqK1
	a5GwcVCf3MJ0ANvZTmFtdz/ql+fvEybxba+7VYTXI
X-Gm-Gg: Acq92OFOIQcK0FVhH/KyumkQttgvazLenKdFMydYCAXz1ev5XUJkOzLV3rlJe95rZ+5
	u9P5S5e8LJuxM97npd3A+dqvatf7r9PdZAensqihLF/7bMKTLG4lKgHPfuSGo2a4SQDrE70bO2C
	ZBa2hp+F5FNNKt110zpS0GkVsJeJwIKksb1VXOJNPluHwKQnJPT2vUXQuTEu4CX5Jhx0M2wa2uR
	0PRXSywWCTSmHZrLHPv+pJ0nIRGTkDsK8towBY3lizMS239KEg8wVvkkrk4GLHQWMRl7DUifzMJ
	RrsRhA/B1+MRz6+2KygN3k9yMRw610wJtiYLlLWp0/9+ZId2
X-Received: by 2002:a05:6402:684:b0:683:33ae:8689 with SMTP id
 4fb4d7f45d1cf-695085d13b5mr21597a12.4.1781558803963; Mon, 15 Jun 2026
 14:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612162257.896792-1-xur@google.com> <20260613170143.GB3152432@ax162>
In-Reply-To: <20260613170143.GB3152432@ax162>
From: Rong Xu <xur@google.com>
Date: Mon, 15 Jun 2026 14:26:31 -0700
X-Gm-Features: AVVi8CfiVeC4233aezHEUet34ga7TDorkoyE27yShVwTmSOfx7cYTcOkCfEkcXc
Message-ID: <CAF1bQ=S6OMwWuA=xaKy4CNvCmsAaJ2DQPi5LnfLyu6x4RnF61w@mail.gmail.com>
Subject: Re: [PATCH] net: correcting section tags for .init and .exit data/functions
To: Nathan Chancellor <nathan@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, llvm@lists.linux.dev, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299624-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xur@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nathan@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:willemdebruijn.kernel@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:afaerber@suse.de,m:mani@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:maze@google.com,m:yuehaibing@huawei.com,m:jlayton@kernel.org,m:kees@kernel.org,m:fmancera@suse.de,m:gustavoars@kernel.org,m:sd@queasysnail.net,m:masahiroy@kernel.org,m:nicolas.schier@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-actions@lists.infradead.org,m:llvm@lists.linux.dev,m:lkp@intel.com,m:willemdebruijnkernel@gmail.com,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,suse.de,huawei.com,queasysnail.net,linux.dev,vger.kernel.org,lists.infradead.org,lists.linux.dev,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xur@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A24E68A291

After studying the warnings further, I believe this is an incorrect fix.

Normally, *_net_ops structures are intended to live in .data (permanent memory),
even though they point to .init.text. Modpost is handling this by using
hardcoded whitelists to allow these specific exceptions. However, this
whitelist is
failing in ThinLTO because ThinLTO renames *_net_ops to *_net_ops.llvm.*.

I am withdrawing this patch and will send a fix to modpost instead.

Thanks,

-Rong

