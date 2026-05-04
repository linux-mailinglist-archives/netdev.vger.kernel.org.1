Return-Path: <netdev+bounces-284023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK1BJI3x+GnJ3QIAu9opvQ
	(envelope-from <netdev+bounces-284023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:20:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CFF4C3250
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10E9730071E7
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505123EDACB;
	Mon,  4 May 2026 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwukbt1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CC31E83A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922442; cv=pass; b=OtF4xA5I3+xgHnJDP3n9NcpBgM8Zcq/4XFvEMoKyNiY9aEBsC2jTRjwna5iUoFwDNQeacSLxtLM+Y05udOkxK+NAatrcLLPbv1ZYGpH4Yf8eQ0sAH3P9OeUuBru7PO/w/PEk08g30sSj8i5z/fPyplY6WI0EuQS9o0a1vql8DX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922442; c=relaxed/simple;
	bh=PKsSkC5CGZdZRhhTcvPVtcRarVcGdkuT2hUJMjnL+9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLYwN1nSF3eW/mXYk2gibbKfW/LmVqpCDy5WNzLGNsjDG8vtcL2CmOi8qjHTcEzelIkrnBI6jwXnTObObyKLXybdGtUm/oM+z9jSeBBEbx8oDQlR5yCWSljTQ53/R3D4YyeFG5cCJJVzSiiwb0FRYmwDYzJpDJMnmiytsCB7FEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwukbt1P; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso48072921cf.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 12:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777922440; cv=none;
        d=google.com; s=arc-20240605;
        b=IS8AkqVg4MFSO6Z2INNNGWlP4T6nRAoTIty5r1MmvuWsede+FiX6OCLgqarDa2nHnw
         Ty+9ph1YMr8noP8h5YqyH/sAIDXY9E2Pk4L609/rCukWIznTWrgXgBcjtoPeblQxbaXQ
         WC6nKSD4SHH+A0CHqpi2rnhcPsdf5d1h4hZ9WMD7vm333E4nXX1Xgkw3ODo94o1gyWUi
         RJw0zAy79Urvd9VbYbrag72KrbozExXqtChIgT8PfFyhK66BntK+C4fkfkrpCAPpfZ8O
         Tbg8bvr/CNegiH/Ntflewi6wVs0Q7DN0ai87ICwed6H62FnT0qsGPAgTUlJsFc6astUg
         G7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PKsSkC5CGZdZRhhTcvPVtcRarVcGdkuT2hUJMjnL+9s=;
        fh=2W8h8PUxu7PE4MX9v9ElpkoloLy1C/qkG3LE0osFv88=;
        b=EIfvLpjjBR5tvT0UiOvvpfer1dCQ3iEEjR/iL89/Q/75sJJMAS3VtT4kRlFrfk0ZnR
         Ld6TtaG8EfmbAkxphYkaqMO4PZh2hzriLIjbxIGdbDcBuEoC7TamWRbD/pQPsahCvYuM
         DN0LHWxUjumbhTaMopAXypQ/Si1klejWaaXl7GaTmDUguaiHKDQnlv5UtnbxS+WIBMJh
         Ijg+xsimOALeHafaO6OjBpJlYNN68jWmuoWbDKfLBGxxvWSgufI7Y9JkUNPyDbKwFgRM
         /YQqc7uRmRd4ZGwUCrDn4P/44JecaDI3TBpPDcA/3DZYkrp4sKc37XjrO8ki5wyCGRp8
         co2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777922440; x=1778527240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKsSkC5CGZdZRhhTcvPVtcRarVcGdkuT2hUJMjnL+9s=;
        b=cwukbt1P7V/0x1gyhZcyIgyMntTVnungxc3vAuxPcj1uvX9Vwd5jILwQ+LUOcD1vKc
         O4K/O5ZL+KVPUZk6yQdO7CnqGsc4NDzHJXhHIlqScuxzyMryvqEmpNiGY+E7qgm/pP+B
         pl4Lp2fqfPwn9R7wljmU2sl1Bd4nBoJBT8eL3VWiHilXMpFhskWWIQ7ugknA55fFHZbp
         LzjevOYcOD6ClKbcXnI9/eMxhzf76jF0D/Sn/VBdkqJwZZUCxCpOE/TDNlcvnrhse5MF
         HFG//K/wOuvsW6DX5K0689/bwy5bl8kuRxsWXJX/35f4p9VXkPZQeQIpQFBOGg21hMCk
         lRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777922440; x=1778527240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKsSkC5CGZdZRhhTcvPVtcRarVcGdkuT2hUJMjnL+9s=;
        b=eKvd3IKS+eUSRgCRIAUlsoZO4q0BjGkgtvcoamaV78BX1NY5tFAFDldfVw331I508B
         byhPIwtkiRUfB4DdvO41dfaRTJkd9/qAemdRwHR9lPLwGXXX3cQLiSszfnC6PJvTVvs3
         0o2tv1vSjxUOqGNtd+K29sfbT4HvFj1bBmSBk2H6ZgP/Y7PErkha3Oss1mQNRwnV/Rhm
         x9Z4YGrvjG9k1ioNV8Nw4BCZqjSpM4hwHnhxU4Q+bVteuVP7kBtC8zrNDgwyOnMversV
         vJw8rpwLjRjQkbCXclCCQ10XRME6Dq2MnvdfjPtozOZV3QoMxvBjlQiSpvUVrPUEEuyl
         p3DQ==
X-Forwarded-Encrypted: i=1; AFNElJ8diHcXSbofNQori5wamvvo5GJXLsJJI6cMLicFmSvllXlscXEiYN6H24H2HqDMjEQZyD+kK2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YygrhoRkkpLB/1hJfXwrjLt0usBCqC+/Mv5RgCar9lNVIYGWgwh
	8DEMC03Hr1YkrJboQxmaJTeaS4J8yrsb5mPH9qnhYRzrWEZxivutLr0Gf+HVLu8qrBCsTOUDeAb
	4e0ArVzsjh/KChEbIthj8XT3DeMVXzKabdXfXWpc5
X-Gm-Gg: AeBDietP/6+twjKhvPQbQ1g3bb2OwQ3YQMWWv6XzjjbHZTplG3MAyii1+w8TkpWrw7B
	mCqsua20BrDZw19nnP5HbTWBsQEnaWcxc0n25ujOE0GQrkCIDVYZXf71Tl3CSROpqrL7qi1jmmy
	WSgScMALl+pAU62sCKkZxEhFQzPNafU6rREO0SFVx2KjGEEcL7sLadHtrszLQbWLLZj4ocpGVLx
	ym/jhb8vr3rEmuDYt0EoByvZG4IMS4OI4f05Ezku91vvX90RHMJeMfiWrpaJt7c2wu+Dp8voYUD
	iwufZDVsYpwZx4p2I8xebBg6PigHyo9eKWtiKOHp0BQ79xho5VCK5nWng7MICNFmZPZD69R4xdl
	oW4tcjgR5jqhLz6Ne3YHaQeRWYwO9Ui/S7ydQlNwt
X-Received: by 2002:a05:622a:558a:b0:50d:86cb:db75 with SMTP id
 d75a77b69052e-5130695bafdmr363831cf.7.1777922439222; Mon, 04 May 2026
 12:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503114515.2460477-1-edumazet@google.com> <CAM0EoMkH-7jjV3Z=74yF4ZKbPsw5JCJo1RRjnt3fEVvzgNbRSg@mail.gmail.com>
In-Reply-To: <CAM0EoMkH-7jjV3Z=74yF4ZKbPsw5JCJo1RRjnt3fEVvzgNbRSg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 May 2026 12:20:27 -0700
X-Gm-Features: AVHnY4JxzQ-rl5sxbdrS-ZdqTM25dZwujQDB3W3Hq51FWHZ-lmqCjmHmM6HfMNs
Message-ID: <CANn89iKAdEGGZ_q09-3EtY_SUhjq__T9nU-jNkgDy2urYsqpkA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: speedup tc_dump_qdisc() when
 tcm_handle is provided
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 34CFF4C3250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-284023-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu.com:email]

On Mon, May 4, 2026 at 12:13=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, May 3, 2026 at 7:45=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > "tc qdisc show ... handle xxx" filtering can be done by the kernel.
> >
> > A followup patch can do the same for tcm_parent.
> >
> > iproute2/tc needs a small companion patch.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> If you ever redo this for whatever reason, showing the dump of before
> and after will be good documentation.

There is no difference in tc output.

 One can use strace and look at all the recvmsg() values, but they are
quite verbose :/

