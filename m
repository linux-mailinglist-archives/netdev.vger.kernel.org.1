Return-Path: <netdev+bounces-257786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMOICm+zh2mRcAQAu9opvQ
	(envelope-from <netdev+bounces-257786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:49:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5AB1073A4
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EF023011C5B
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B6634FF67;
	Sat,  7 Feb 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHRdB3K7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEFA339708
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500972; cv=pass; b=Cta3JhwOm8KULpXa4JXFXEMQXpnSwDz+M1BgMJauGrJuHw678D0AaYQgKrMp8aUgyUJr2qNHTt+2JXnhycE+yjlmteVs/8M2t1xBcrlSGtqd7E8nvK6OtACypcWQIeYIOmcRJJGMLbemdDp9u7xb4LG9XQO8XxOeZolLDau3rPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500972; c=relaxed/simple;
	bh=AJsnbOS9QPRsXy+L8+4MQrLW2cfglsF3jPbB7kq6TYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS+uTZqvnxTFC4egWCtc2vtIFSohM12CYMsLuU6pYopLZ82kA3+C+K5s63E+nflhMOAVYo+1eK7QU4BcdR5hHbvk0piBkLEmtvhjuWSpiYQqiGB1q/+qmfZ7WfYtXxpy1lYNCPocIR/esFzqLJ4UHh5YkK9wXCARxLk/HnRyxoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHRdB3K7; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124a1b4dd40so6259528c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 13:49:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770500971; cv=none;
        d=google.com; s=arc-20240605;
        b=claIulvK+USNgvQKV9MTYmPYxcNkv7CSL/KLlyjI/kV0qeCzHFJhJMAmRZte95ZwDR
         TrIwFfB66zrWXw9SKSytdfAbNJV7b3nhB9aeYztfMlO8DaOCQXHbMxf7+gtg8uZXLcNX
         LqIrAifyju+3KXlavz0Tz29qZYb7GAmBC0GkMnMq3IIVNyXvNf1gd+d/+EWqBe6eSHYR
         ZVl1z4vBaTjRmhX2fZDnSzvJj/uvLgkAhqvBzg5WTIB1A1xklczLTlBp5R2fV0+KXls2
         fkCZ10mlZP/Tib6fLU+8+9edVUo+W2BqzL4u6UZ6oQzx/E+/aIvHeRgnbPTunlqm5TPm
         o+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AJsnbOS9QPRsXy+L8+4MQrLW2cfglsF3jPbB7kq6TYY=;
        fh=hBZ/XBi4E9fdvGJR2Nm/Ob3peWAOR1I4cmUT+VhXCAk=;
        b=H3Jd0SwDZASMcDvA6c15TbafDxJY4GiBoLHSZZsYEVCrnvQLNXfe9esfhDeRZYz/Kd
         mLQjENp8V5bYEUWhp5cOMTscgp5wSngQO/unOj6yEZ3Yr2jyhxjAiT61WouzTXgYwzpY
         97eAXNqD3dKvYwoWGqKjIkU8WUZzO3BiLTWf6rNkiSMdJbqvnofLKeovFhoFB5XeVx71
         eCZqaQ5M1MC2Kw/ClYpQcn27fWRI3Qs+fDJ2IRznIMMOsDmUUDN2XRj+lzkpdZNIEnvq
         sQFFNpy2ZtsUHVlK+OwVAeRkQHO/2qHZMrLYjrcYaDfMJ4A8huALJnUCGX+LvUeo6Jgj
         K7Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770500971; x=1771105771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJsnbOS9QPRsXy+L8+4MQrLW2cfglsF3jPbB7kq6TYY=;
        b=cHRdB3K7D70jrRJD09WFDsQklLa9YTvrMJNfLX6QpGUvQWBTK8C7YxvgXcYnCiI3s6
         w3u8lXamNWOsGWxjBV6Mf50k/QsQd4i/wmpVA+BCUDUvg9lck7SnR2sSromX7Jx93+Tf
         ZygztY1dGaGbXpqFGwpyrm/gnm8iIYgg5SNfYow+Fgl4wBGatUcKkVpp+7/ykD29092q
         DpYCOqkmzJBObAEi+V+aWqZvjC3z1gowY+8CzxFsPQeohrsVkhG4wx2MJCOM7jkRckNS
         XpuCOwXly6/NEe1RQruWv5601ClLlihxMhTeIA+okEiwTPTCGnZhGKXlp0xtMP9RWmgb
         j6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770500971; x=1771105771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJsnbOS9QPRsXy+L8+4MQrLW2cfglsF3jPbB7kq6TYY=;
        b=wQLFGUuK2t/5783NctlB2J7GLSftdIzlXoW2/asyos/VhFMeXAh41k95W7/uCWmwvD
         f77WEyKHXe7MM1y4AxgIcLOcQ3r4a9UxfhLVMLnG4RR8lTD50vg+5Os03ZOIJljAgeeH
         JxjwhJ0JOt0Ak7RhLH0xm76z8qhjEUDANkDW5ya4DGb2ityF93iqpeXWCpQsIFPqfzP6
         AUzukZdEN+uutjkHOyJDojUVuvAAT4UMbISn76jWoZKiA8aELIKrNB0sBWTH0DG6AYYr
         8hQxh4Po5/5ArxS9g8lY4hztGDME0oQUm8NjFu19erk/6FQeLiCxfhrVF3px69yhkChG
         3nzA==
X-Forwarded-Encrypted: i=1; AJvYcCUiXK8bdDhdYcNcMC+Swo3nHeEIEBhvKrs5+USjqdHffG8ODoNEdRoepJPIcER0hbXLOATBcFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFeeF7dJdUM5lyJ9JhpUoNDeNserJLAKO6VMElO6zhiUTId+0
	2FtXQ13lqJg7VZ3s14qii3K4QMmv4sQgDVQVbNFXaSlgR2mkacMDl75dWCLtpHwQVUU5cx5waaU
	HB985bY9EfLoNGbl8/gGEL6CZl//XvYR6bRGD4HVp
X-Gm-Gg: AZuq6aILIG87j9qTTGtlAkccst/q2xyUDiJKWNAO4uVpmmqLj4iZAJlEfvXGKHMw789
	UGGBjzO6NN4dUbZJBevknhI8dKwq5IhDq+PMQpNZf11EcEn6RrTxDpSFbLMyLyU0CdCM8PrxTFE
	WNnN35WQgcfH76cp5M4HNiXDhpJFwa5gtf7C+lARxr8sSaF2ueq5J/wKOtyLSX8YSCcQiyLVjaV
	88Ueon30zpPEvsm/kXqGkXlKU34A7TUBX57xMTNQrvt2GY0+V1TPZX2sIFwdJ8OJFnCXGWbugMK
	cBGw4xIzK3JHmc6Y6x7vhn60fvu9cK65tX4V0X7o5yeaP+X/YC8mOdqeqKmghwOC8ngl2Ag=
X-Received: by 2002:a05:7022:4383:b0:11e:3e9:3e9a with SMTP id
 a92af1059eb24-12704042917mr3424050c88.50.1770500970931; Sat, 07 Feb 2026
 13:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com> <20260206173426.1638518-7-edumazet@google.com>
In-Reply-To: <20260206173426.1638518-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Feb 2026 13:49:19 -0800
X-Gm-Features: AZwV_Qjl5E68Fg1QXgcU4cSVF0OiUVjrC5ZWisR4vfgL3133p__2noHuGqw2H4Y
Message-ID: <CAAVpQUCMNphu+3VCFGtR6RxsgTO22r_995_ZJ22kvHv_fQ=Z7Q@mail.gmail.com>
Subject: Re: [PATCH net-next 6/7] tcp: populate inet->cork.fl.u.ip6 in tcp_v6_syn_recv_sock()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257786-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7A5AB1073A4
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 9:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> As explained in commit 85d05e281712 ("ipv6: change inet6_sk_rebuild_heade=
r()
> to use inet->cork.fl.u.ip6"):
>
> TCP v6 spends a good amount of time rebuilding a fresh fl6 at each
> transmit in inet6_csk_xmit()/inet6_csk_route_socket().
>
> TCP v4 caches the information in inet->cork.fl.u.ip4 instead.
>
> After this patch, passive TCP ipv6 flows have correctly initialized
> inet->cork.fl.u.ip6 structure.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

