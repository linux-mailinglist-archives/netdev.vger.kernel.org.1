Return-Path: <netdev+bounces-300991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o/CoFHnwOGpUkQcAu9opvQ
	(envelope-from <netdev+bounces-300991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:21:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA86ADA18
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:21:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=nhc5UFm1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300991-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300991-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7032B3019443
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD6E38F925;
	Mon, 22 Jun 2026 08:13:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F8F38E8D3
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 08:13:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116029; cv=pass; b=ZIf+MeOVPtoeZQq9ssLJKUPRVXxy5cQKL3YCh81pwJWYi0TEhhsrderIjlSJ5CvakldGPp0LWxhTZIwUvwZmsOViX3stdS+nq/+urtCxoI/JFz3m0M1GWnt4C4+DorqP1eenWtWmcbOAigZePp2Eiciu6KRTSG2Az4QBvm5+/N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116029; c=relaxed/simple;
	bh=waGhTRw14f0g1tf/crRVSywDMlQJkAeMXhT3JQv2iyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0/YhvDcvhTCOnSPhYtJV/XA+jcRO3QQsHlLqo98A7kXkjNmtvVPAJv1ER+Ru6+xC+uhvo6TuUqp63bkRcP1zWHRhuash5HL07ShWzisvnBlZe9lEbTJjtkRFLtF2YQUbxd4inCzFgXEij0rO9xiHrmRZeBisgnxRQXDNwZnBLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nhc5UFm1; arc=pass smtp.client-ip=209.85.160.179
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5177945a279so43133281cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 01:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782116026; cv=none;
        d=google.com; s=arc-20240605;
        b=BcBmazSmv37LdpFnGPkPRniV5lYJLPbk3AlXeNnVuVwqezcSQCGdsADeKOGKAW+K/3
         sQ/admaQvtfKYu6MKG3HvGtY1bxijqaoaBJI3PvPwK47esQ4Wjx8HmBywOqHjeRWrMXv
         2HIibhgh91yOzAQeRk6BAM14A23/FcPfVPuKHwZ/Snr6UNxh6wbmqOBwkumc3pGTIgIT
         uWo1UD2jX0nuzs6vJwSwFHstKx5hxieMRYzsqQBLNeUnkjTM1+Kb3RawvBVjv+kgiNyl
         nxueWbuF/iuIWpRpj70+mxt5ucTdeurk4S3eL6qqneWvgxhRWdc0O8dYd7fVOM/lrjGN
         98Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=waGhTRw14f0g1tf/crRVSywDMlQJkAeMXhT3JQv2iyc=;
        fh=j3So7VXCjcJlF3Jbg3T2oh+8UaEHhjh9Rhw9M9idAN0=;
        b=FptPW4PkHhpPHtldmhXSdI3BJVr6y4kgkpp64fZY8o0lXDOcgfyxN4rSCedt0cjh9b
         9sgnVLwJhTHxHQlGtWXTeYAM1twlaZCpCAa2lVlr7Q6mdqnIaW+QObwXUet1uCzMv6BV
         W7CMN9DGorZ0y8Obd/Kv4cxbsLohIsI5R5vsldyLnJZIHl2uNM1uj1XNT1swBflo/Nii
         ltMNCyHwg635a7+qQrQPWybc0pBi6msTIxGrT0lbbPlfuJ4XBpQrMNNqnExSvYaZVDpe
         X7VQQ0FP2ulQGRXh6oGsk9exZlonAKQnzEjjgC5qMsQfuSlaSRQsaNuwyooFaoEhQoQU
         JyJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782116026; x=1782720826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waGhTRw14f0g1tf/crRVSywDMlQJkAeMXhT3JQv2iyc=;
        b=nhc5UFm19e8tkjEGydBUbrPlSQeGNehg77oBg5XKmVi/oMBFTn2d/uvGSUwhV9z9gr
         61zX1J1Y2CNorNG+yAXTqgVymBUQe+exNqzsa41l1fJjvGQ/fsyLKphhlIk/xNcL5PpS
         XZbMs8zyEtsGanxOs7/SUd/hCP2+UfLu27JAuYSm0Rj8Qxf08ptMJ/x/zD/qMR9PGzJS
         SWrjAZp9lRTloDoyQJcgKXqHL7kur4kq/wEd2v0LAzRjlAd+APDRy1IvG2m9mAttAQSA
         4Zh1+QBq0DggnR+76O4BW0lVqHHtBKDyNhlgompYe220d4N9IBU7jXNwhs2JEoy26JoB
         wF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782116026; x=1782720826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=waGhTRw14f0g1tf/crRVSywDMlQJkAeMXhT3JQv2iyc=;
        b=XHUyKmfnQ1WZ7rhYasi2BDrMYzzRmNIbf7Vu66TKb/vwsW5TyPXEEHJyUfUvOMN2/A
         vIis49QQI4IhM1/nbTzfvRX9UNwa3z2csFUuHnG6fquxKMjSVFhehj0aPetulFhXEzeG
         XPRgijg2wU4tEOkt2LQVneb283F2rk79k/q9dRVYGEKK52+lYaGEQsVJ8nF2D6N1h3tg
         Bh27uhnCNQAFQE39nX22POyhYfwE1CQa+3xuP4SgwdFe+PF9MHu+ZBxAEr5MH2IUQkLY
         RmUrethN4+6IPxlI6d91BFWWWwbSjld8RbCWhKf1ge19HMt8LcIN8p28nlx42xs3S8GB
         rJDA==
X-Forwarded-Encrypted: i=1; AFNElJ+dFX6ZbzcXAu9uSkIvmnZ6o/bfZtsETAw66WXakuO4rkreY+SoxfDvLZ9O8V/5dc8t5ahaSY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwud+KxDMJua1IWUfTHmWPWXBi2sqtaHhkTWmYru/50uP6lrR
	1s8WQNEbUzgYTNcqy2jjGEkz9UWJaqoo92JjpXZe7fyyNVaPSsZv88bO51iop6xO4+avD/61cWG
	edxPCGFBGGK4SuuZKMQsFtTl0Yif8FcwrdH0o8hbO
X-Gm-Gg: AfdE7clEGCwwjPyakRBzy5wrwnMyGWuRipGO2qn/NTYwhaZ9wmsue+U6RqeNbqn2jJT
	M2t+WurasfnpUONIyK+SU2iYW/KLeOZPIMCwt3jsEc7NlRDsWOFNNpxSkSwqZQMkZA2eTtVipaj
	eZHyj8H4eq5Y3Ag7Nh8i6JFs81MnhJuwxTDNyltYFH0EWmhyEMv4FYDUV+dSDLVkpNC1Ka38Qsp
	kFw9zTRqLYDY3Rm8my+q3pSLAtOzWaMUEXswK6jQsl2fmAZ+651rua52cqhN/zRc46B7Mnsd1Oc
	kD8AJuCNnTH0YAAn5d29w8GmTBR3rmkZTb5A4OkxaLZKlx8YSKZ2Qnjnth5bUlDVpt2yBzQKcpl
	EWSzBcNfO
X-Received: by 2002:a05:622a:120e:b0:517:5bc1:e1f5 with SMTP id
 d75a77b69052e-519e46ce98bmr207294321cf.0.1782116021889; Mon, 22 Jun 2026
 01:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622033118.244651-1-yuan.gao@ucloud.cn>
In-Reply-To: <20260622033118.244651-1-yuan.gao@ucloud.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 01:13:30 -0700
X-Gm-Features: AVVi8Cc4F5keFuoGm3qPDcQD-SxauhcIiasSatWzT4ltkhz5pXyD8RBQBw5W1l8
Message-ID: <CANn89i+hKw-G3jewJoEPgGu-BOWUNuUn0RMdGh5L3B1ubD+OMw@mail.gmail.com>
Subject: Re: [PATCH net] net: dst: block BH in ipip6_tunnel_xmit
To: "yuan.gao" <yuan.gao@ucloud.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yue Haibing <yuehaibing@huawei.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Kyle Zeng <kylebot@openai.com>, 
	Kees Cook <kees@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yuan.gao@ucloud.cn,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:yuehaibing@huawei.com,m:kuniyu@google.com,m:thorsten.blum@linux.dev,m:kylebot@openai.com,m:kees@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-300991-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFBA86ADA18

On Sun, Jun 21, 2026 at 8:31=E2=80=AFPM yuan.gao <yuan.gao@ucloud.cn> wrote=
:
>
> Similar to commit 1378817486d6 ("tipc: block BH before using dst_cache"),
> the dst cache helper functions must be invoked with local BH disabled.
>
> This ensures proper synchronization and fixes a potential race condition
> on SMP systems.
>
> Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
> ---

All ndo_start_xmit() methods already run with BH blocked, can you give
us a stack trace when this would not be enforced?

You forgot a Fixes: tag.

