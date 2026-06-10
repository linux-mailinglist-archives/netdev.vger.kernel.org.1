Return-Path: <netdev+bounces-297676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +6WhAZ1hKWogWAMAu9opvQ
	(envelope-from <netdev+bounces-297676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:07:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 913DA669964
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:07:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=FF1R0mNS;
	dkim=pass header.d=redhat.com header.s=google header.b="pbZMc/Xw";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297676-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297676-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CCDD309B29D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1EB408017;
	Wed, 10 Jun 2026 13:05:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9C408013
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:05:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096738; cv=pass; b=ka40lhFkb+d1arX6Xh5iguT+S6mQ1dS1e5qLi0fBgAhk4SVuRimy/FLRqaTHhhgxn+TbsDWGQAlp8L3c0FNR8WyFTFT5/FslZhf+jwysM5HLHsKC0HPJgMuv/uqk64NFQLQ4NzbXKTEyq9uUuFHjHgOmgC+XjirxAhs8kQoVeTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096738; c=relaxed/simple;
	bh=QHUqVSv2KaaURqb9cPHR7aND7tqFpUEAhdFRJWdcb1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxWxS59LvTeTxSRbsfbFFy6HyfFjDaqYsJK7SU5X3GrBzf4j9lhjLIj4+WwaEskIXvdtrO2DyOpfUP5u4TaQNadDqpdJeem1tyK07gqEABnQDB7Ve5HkCMFVGOb6F2LcVP5bNhfdtRkvns9zT9+YtFlyCll2habCL+Sfasya4jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FF1R0mNS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pbZMc/Xw; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781096736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
	b=FF1R0mNSlAX28LC5XueCAxKk1qKP+3av8B3vRllrD5DQSJQpO1tM2ycBH3wde84PxW0INq
	/Q9EGJ27QsnYsD81eIQMUibroBql4ZNPrDloncvxnviqPlPIXhKJM2unKSohMWhE7l4ID5
	+rgmX+MnEJc/jbY9WKMV+UXzbXqIzUs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-KSdhG2P0OIW6qOw-nqBSqw-1; Wed, 10 Jun 2026 09:05:33 -0400
X-MC-Unique: KSdhG2P0OIW6qOw-nqBSqw-1
X-Mimecast-MFC-AGG-ID: KSdhG2P0OIW6qOw-nqBSqw_1781096732
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3967e27c060so31325051fa.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781096732; cv=none;
        d=google.com; s=arc-20240605;
        b=emY41YS+IKJVBi+b3RTGYmRxlDuT4BGV8OQYKtnCYR+dqDMG7V/usJXBlD+FFj3TOF
         O+E6+gawZ8z+FF5vNhsf0tFWZ5X2kMDj1BBtlJjz6pL9hBDMBB4vl3z0xehk+xODWqGx
         7KALFDwwjj3pVkKrjIG8kREIHRtyXV+FPDRpcOY/oCYFJqqzBiN+qmWDWMsSks2uRWVj
         pjyrlIsEe7cbMRDkLQe97fCsOPd+0PtHXPHXBmxbnGdL94CVNB3lr8ixrYabOn+7MYgd
         7uXgx3HF4tkIH3NW0onhD1UiJ7hHcwKt/nYOTu80Q/jFro6wkyen9NTZ1jq9l+iNLVpl
         +dng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        fh=eo5gGU77v4om2D/5LEvMwGjBVbsc4nWlpq955pC6DCk=;
        b=YffOhiwtg6U5Rm9CudRwUppSJjJQ5zl6BHSQORuQGjn8tM0w2/a4zphbkNgOEfKT3a
         ttJvzOu3Syj5zhne9q/pD1WHPI+UTHX2vMlmchvpgWPXGB8YIz7gsKAg6pCoSf2ZnS8d
         YJ8DI5lsoIOBRYPLOMJAEGLJmph0WQX4M7RTTDhlESWPu9edmREFfJt/q+2ceAMjqaM8
         xNp5hkOQfHkyNQNmSsFbkStN6nHHmUAxnfZjXfK3FvtBxJfZKwiRRSG8QG3FfiLmEo4v
         f+J/N6t/UAR5elI/LJEHb+rhF5sILnEEWJFrvZcCqsxdmhwGfBQEGViQdikSwiTkpE2X
         ZYJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781096732; x=1781701532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        b=pbZMc/Xw+cPI5jy3mjU1SS2z8qNoejkT16j3tFJa1c/2w/H79vvfg1xiLjjrsUWccp
         ivurrxwIi0A/sIfXvtKNKXHGiXqO5lBB9sOtdMSfuQ99a9A9WxDgfzC8vX3+OJEDnBhU
         2onfxob1uNwfnPDYaSzG+EVflq4NYkhGtqTMVBfS0Gp1pZftiL/AHqEFahSnBs5RBlyk
         U+YFYD11zHaj3DqbGWL/0pVotQGTgcnJTZ068WANRNl8DFO9K1DAwziGLIU1lH9BpYhp
         TQOWXU+dD/drm/4OR9zjqJkkSBXzehx1OzEcFqMurxWDwRp2OQcAoCG/fYu73sUI0+R2
         3CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096732; x=1781701532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        b=dtXu8xU/CKzs5Uz12E7oYQTCIs2Lny6AalOBLhCd/j8Xj08UCpeh43f3yrf74xArBu
         IcVX+BF9aM8XiOte8KnOyAL6T2pR543zXsMHmcQMjz4U2E0QFYIhD+fD7Ic8UJpqrAXP
         VXM00PlHwuulUhzdiJ92HrFik1cYzypPIaT9a273fu+EoTqK+oRAZp+eGaT63bOjoUM6
         oukdbgBRSCB30xYBNMZxpS+CbaO0nv1dwergZ/hciwdOuFO9sS9Y98RoKg/4ssr3eWsY
         26lYuK3EKcKetLjF4nf9IQpqpBVGSurYVpxlA4+cCmBj08mj1lkp9zBXAoqDp+5E78NH
         NgoA==
X-Forwarded-Encrypted: i=1; AFNElJ9GOSSbk2ocR624z+Q1J2F/IJ6KD2YsRp7O2Rc1aa3WolkfnENvoEZ/QHW5M1zOKwuWZyi98YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wSXXGQ0zIjssI2HY/3eekj9G9+CEmT+B6DzVF+ys0ZnFvCuG
	droVARtVo3iuGE0MKuS/Jv51hNp/CZ6JDAezru/zcVKZmug88jsB2Nyu09ODDOOlcKhGslygnQx
	MP/L/Do+2JtLkhS72ROQxRqIP+Oq7YcLeuEXe4l2l1kNK8CHgdww2/EQm6BT3ewxRC5RtLTsJ8a
	9ecs7XLfVPx/lyOPmQ7P0WZjhfweESrEy/
X-Gm-Gg: Acq92OGNkvnkmbKatpj4O/Ii2ywlWjaEyxvKUX3+BQ9Fo39hXDuhhW3pWYFxwz+qR1A
	6U4nNo18xVFHxMkYxQlsCIpqlbOHlcR/H5slSzIjkHjWCrg0glIGxZn7vb/a352gFoDRSqPCsxI
	kA47utaefO3Dl4RyRSo42VfB8GzuH47QUVyQcUqVjNw3MDdhHQgoBMFE60LLEmsVUvkqNgaZ4Mc
	JvYhiA8L/TDqupPmeO/zEdQKX053ibHdkCo3/Eed94Op+rQ
X-Received: by 2002:a05:651c:30e2:b0:394:987:945e with SMTP id 38308e7fff4ca-397f76b9dcamr15845921fa.1.1781096731787;
        Wed, 10 Jun 2026 06:05:31 -0700 (PDT)
X-Received: by 2002:a05:651c:30e2:b0:394:987:945e with SMTP id
 38308e7fff4ca-397f76b9dcamr15845841fa.1.1781096731250; Wed, 10 Jun 2026
 06:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 10 Jun 2026 09:05:20 -0400
X-Gm-Features: AVVi8CdjmsGRE34cD71VHNMaCGfKHZ-mvsXk7Qa_Y4MIS1SxRudAtkLHluKhK4k
Message-ID: <CAK-6q+jL4D6cCwJYr3AMb_h_gVxCamNrG=bRrEczhN8PVRVPOg@mail.gmail.com>
Subject: Re: [PATCH] 6lowpan: fix NHC entry use-after-free on error path
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297676-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:linux-bluetooth@vger.kernel.org,m:alex.aring@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aahringo@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aahringo@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,seu.edu.cn:email,tsinghua.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 913DA669964

Hi,

On Tue, Jun 9, 2026 at 4:03=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> lowpan_nhc_do_uncompression() looks up an NHC descriptor while holding
> lowpan_nhc_lock.  If the descriptor has no uncompress callback, the error
> path drops the lock before printing nhc->name.
>
> lowpan_nhc_del() removes descriptors under the same lock and then relies
> on synchronize_net() before the owning module can be unloaded.  That only
> waits for net RX RCU readers.  lowpan_header_decompress() is also exporte=
d
> and can be reached from callers that are not necessarily covered by the n=
et
> core RX critical section, for example the Bluetooth 6LoWPAN L2CAP receive
> path.
>
> This leaves a race where one task drops lowpan_nhc_lock in the error path=
,
> another task unregisters and frees the matching descriptor after
> synchronize_net() returns, and the first task then dereferences nhc->name
> for the warning.
>
> With the post-unlock window widened, KASAN reports:
>
>   BUG: KASAN: slab-use-after-free in lowpan_nhc_do_uncompression+0x1f4/0x=
220
>   Read of size 8
>   lowpan_nhc_do_uncompression
>   lowpan_header_decompress
>
> Fix this by printing the warning before dropping lowpan_nhc_lock, so the
> descriptor name is read while unregister is still excluded.  The malforme=
d
> packet is still rejected with -ENOTSUPP.
>
> Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

looks good. Thanks.

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


