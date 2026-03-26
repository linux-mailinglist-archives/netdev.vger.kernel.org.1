Return-Path: <netdev+bounces-272100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILNhL2ZIxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:53:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE9E337156
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8FE73117C9E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784C395268;
	Thu, 26 Mar 2026 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXaBPP8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4D37756C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536250; cv=pass; b=UpmXzmiMPhvJ7yfGTvPvlqBrPHSZFAvu26b5mNFXfL0hW4SeYOWzykpOm4ZuJe70PRoM2sTdLRZ4cf0vK02YrK88hwW6yvO0SXIBUDIJv1j0PGLx2YsATJpNYSGs9NYSnOmJUCEnozE2v1i1hSJSUCdktqYIR5k5lrk1yeUhltA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536250; c=relaxed/simple;
	bh=d2b1AenXbF8WtFPruJXyv0RsQxaTrh+JdXuGW9HMB+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T45z9GlwPUr8vToFZnsKdJg7WiKbPn1fc4u6wIvRGY4jcHKcwdo0kDxcXK+ZFefOcWv2nJNNb5cCPuLmkgDPzsgPL5Ci5Zk0d5/Sfj1CjzoSeHikEt/X2ZxiCyfsK3T3R1j0sZP8CmKeV4xxr2enx11PO9U83E/rbVRAuzDGpHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXaBPP8c; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c4b5dfe6cso542401b3a.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774536248; cv=none;
        d=google.com; s=arc-20240605;
        b=Wuw+Zih0PxnTM86EZox1bIJ4WSKbVX8mE1QarDHO1/7qtQg4yvgJOzfrIotRMNkxB5
         mcE3QMgEY28znyeeKyUiRUc7GvkG99tdChjTyL8ks5LPkGXvSF/minkP8aQZ5DitK36X
         9PXx+0qhUJemRg5pkjF/nIy44QBCSg4LN9Lf8rkHIsKC4gE2wgQCoyWiROso7GJvXYzu
         +lmp0NNZ8FCBhihuqEowpZBLtEA+CVngpK4A7zBV8/GFlN30S8Rfz7VMkgKViXL16Ctj
         Idpqc0HbNbvwHdI7gxg4wbH0MvNqUhUzFBK7iqze8Gq/p5wArAThV1AL4kN34nqj2TpP
         Iplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d2b1AenXbF8WtFPruJXyv0RsQxaTrh+JdXuGW9HMB+c=;
        fh=MNeE+mtGKZbogijNDjRbKxB/8kv888xxZOWyE5JRC+g=;
        b=IuyA1vK1uYmRtZ5a5bCSB/EBiSIw9o+C7ImvDF87E/HkJNzEfssgKRuZw7zgXuLjoD
         j5PF8R7y2Vm47aggfKyYRtZbKjjA+7zI0DorcM4NyTs8C2RcdW/34nfelYgCuH86LuKQ
         vXPSeGV4C7a+eya6VJiclzn7skEdtZMmdI2l3RanEMmj5D+39qAtqsMkNprq7j5gCORO
         MA8tu01XcpYP6JfptqYzny5eMTzNFB2uvPs02vQh47tJtQ+R645XtoESW1hrneQkBKnM
         6daa8wjfTmOKqT5HwJiySJOJKMneEL0Hm5b+RpttVzwQBmNgqxLwcMHSl1NKfsdXEBh3
         xIWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774536248; x=1775141048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2b1AenXbF8WtFPruJXyv0RsQxaTrh+JdXuGW9HMB+c=;
        b=TXaBPP8c7thizJAJNA79E2T9QrBHA2aINV9d6GcBkQsPnKHXFT+R0db6fH5vA54ZTP
         Mn1ALU89uvbAxuyJw7KomX83UGwUh+rdMjCs61R0/HYIbz6WWofEYGgpIWoJoSFCBEsy
         gVNrJSJSczAy7NIAOMq+KFjyDwZQPFlbBIFje0DNSVM7kKq+ekhnF/9c6m1ElzU8e8on
         WNob8E45z6y+8dWQEqQ41giAyZUEF0w38qsk6BEZIgyeXUVl69Oq0u/2o51vYQrlhBxF
         w8UCQ+GpfI+xZnwm5HFaIXN+v7Wh7RR/aZISYCGWeSQ60ZFZXwTGuZjuSUFapvsHlj8q
         wCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536248; x=1775141048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2b1AenXbF8WtFPruJXyv0RsQxaTrh+JdXuGW9HMB+c=;
        b=Fyg9JOJvCCT8wNh3A4nloulImPs2L7xNa4kr0uWsFXPxRi8vDiLwfPXnOhBfQ4Gajh
         /qJhuRdTFqK6z+tCxie3/KRCACXba0X1dTEtWulCYKQVrmWR75HJJ8qqrXvrv4QIAxX/
         yfZrO9Lwa6FRuUnFUlk3qL4AYovUEG9vBxbj1cROpyJclSo+gBMliz7u5JkntrAU8J8m
         LqnptZh2QtF9rKoL/kc7BRkWbVfy3oU3BytUVBFUj3v8B95LnIkhamg+YtURuOGVX+t0
         FzPqCfxbq58arHOKt6NTpEBDxJ6mQLl/PQvGj0aCY0Dsrwc2ArJjirSoBiI7KnpY6uDe
         6DQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5+4ySy76Yj/KcCcMVjJu9+UVbeMLvFMxOc4nnOLxZfK8OtKma4NJ3HCwG7egWIzqRJIwG8UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyvGsxfQ0jeugIzmBWEbuCw3hCH8ZSzIKWSTaX4Q0q5S4jRCUk
	1+lWOVtB+8MRM4gaPXALhNnH4gBqwxwnY2Wp11fxgMtDzLVUHw2rgdTnzwJ8fOQU9kci5bmMldU
	WjlAhyX78XE/EBotgyaPAjiHtXCk+3Ag=
X-Gm-Gg: ATEYQzyd0a5MKs5QtfABjBN2CQKD8myOk75JClfqNHAoAmjeMTsViHAre+BhR6sITXq
	oKU6dl+P3HgEfs8pinUfVDXZUSqJc7R8AFNsIeKtmeIF+thxvOIgRt13rVPm0w8qbYuyX4i7c69
	15PkcBbkLfAz7LxRKedBIBZZCKROc5MajPYzfaL2WwwB+4yMu4zGbaJpBKiQgw7dEFNMrPCqnh5
	NqMNgc2fNGl+UYG9zWYEolDhRzYQ+G4XL9IPZIVT/4zwfLbB7YzZoRvVYLzpoK9ehjSaE7YRZGI
	R7io8aLTIJKWFKcuJPu8FJ4r1YaGkzAmxt9T9XnjvIXA2LsS4clHrV4iv/Oea1oKrhCECiuVu25
	+XIQMVP1aQadrdHdhjw4msVWwb4QbpphoLwGsaWXM
X-Received: by 2002:a05:6a00:f8e:b0:829:7057:b99e with SMTP id
 d2e1a72fcca58-82c6e14675amr7240862b3a.54.1774536248015; Thu, 26 Mar 2026
 07:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305013852.3769-1-dqfext@gmail.com> <CALW65jZRyKydW6bs-mYwh2mEn0dpv3opVEr=WczKn_0952_+Yg@mail.gmail.com>
 <CADvbK_fj_26MLP=+U+rzOMfqdPpdvFQJgN_fozd2uAjRsfHweQ@mail.gmail.com>
In-Reply-To: <CADvbK_fj_26MLP=+U+rzOMfqdPpdvFQJgN_fozd2uAjRsfHweQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 26 Mar 2026 10:43:54 -0400
X-Gm-Features: AQROBzCmY5h-d4E66DSyoIkaUfNQKP2g7Esgvdfp7L2gh6AVWsUfdsoPzpij108
Message-ID: <CADvbK_f3LwEt+-BG-1Pcr4jMn6Jxry+0p-Fu_s0C6Px+F_NHCA@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
To: Qingfang Deng <dqfext@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>, linux-ppp@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Richard Gobert <richardbgobert@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272100-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nbd.name,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1BE9E337156
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:43=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Wed, Mar 25, 2026 at 10:43=E2=80=AFPM Qingfang Deng <dqfext@gmail.com>=
 wrote:
> >
> > Hi all,
> >
> > In some cases (such as BIG TCP) a GRO skb length can overflow a u16,
> > then what should I do with the u16 length field here?
>
> I think you can either add a check in pppoe_gro_complete() to ensure
sorry, I meant add a check in pppoe_gro_receive().
> the aggregated size does not exceed U16_MAX, avoiding BIG TCP
> behavior; Or, set phdr->length to 0 and rely on skb->len to determine
> the actual length, as done in BIG TCP itself.

