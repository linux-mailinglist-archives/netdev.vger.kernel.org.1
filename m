Return-Path: <netdev+bounces-275899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOg9KXu/1GmWwwcAu9opvQ
	(envelope-from <netdev+bounces-275899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:25:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 012673AB441
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FB663004C75
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7793A257F;
	Tue,  7 Apr 2026 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1l9MpC3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9773A1E8C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550103; cv=pass; b=gG5ZKVRcc3m8cMM2P4383BRVWLgYkKcGB4ccIL+oZNj4gXC4WWetZgRKX25q5oWyae15HViA+zTTOV9wxV2mJyU03VhgFTe8I//jQyzSnFd8+SlhmKqzlCtWEk6cTxRxunjUtKVkRyKjmWVBrblTrF/5dOsDx133bJK9SItQuLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550103; c=relaxed/simple;
	bh=7ycrS9FhnA0qDzg3E/0jewmRkYl3w3jvUXrSoruqoAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+OfN5OQrAi0XwDAbPwJC/J185eZlmpI6NSIxHyEHGUe6tjSgnPSsm7aQTOBFGKUp1AEiXUwFdimlCgpjkoweqa+69K/4Dn6zyylsUVGCYDDe7a2pZKtgv+4dTSq9cp/XYhl5M2ue2EdaL5EmsPq7i5/O4OPlBstsKRpyy54JOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1l9MpC3; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38df1889fb9so23513631fa.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 01:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775550099; cv=none;
        d=google.com; s=arc-20240605;
        b=EJyc9EGuJO3BBEwj1bBBWwUNP+YU/9cyETXs9uI2Gc7TANHHcy6bF+IX/wRVawAAUz
         9g2swc8WdgoR1N/O09jU5bX38DBdNDF5JLsK7aNS37GCI+4EVHmUrD/C4EizE47DDB7a
         34h807BRsaJpNNLOv/vfWh8DcHiIhEb0O7CCR0HUm+CSppFfC8sMHytMQoBSIIc5+eAe
         RKIK0thduP0eusgPMOM5PYsNhmubJneUpAvxVg0QlS3RP1MFNafT2SGfz23e1jA5Rfwr
         3JymLYgxtKEzUaeTpdIjBvlI7cZvlM/SRUOQN8mOujcGh5PxTSIxUaVpVSKENOBEtPjg
         42jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ycrS9FhnA0qDzg3E/0jewmRkYl3w3jvUXrSoruqoAk=;
        fh=kyWL+fOH+F/WSwHmwgZyoBnwTTDz8IwsD/fTE5bRxrM=;
        b=Zfb/msEczGW5Regy/9VNlaRAr6y9vUDPqZfXYKt9VauSQa7oTUMLVSGSriIJe0Vj4r
         Lih/fnqn4kiaOnD7jrib0HWkWCFb13Ry1Jyg8OAw5sqGgWyIfvcekKUsyQixw9CkTxZ/
         PyNu7c3L0Qd/zyfAfSu+qyepzPBb0NhOL5CG9Ywllxlf5YHe8YjYaRL93Xosfy9I66s+
         APkiy8JWoHy/8MbUyjym3HP7a83ZnphO94pif6QteixXEYHEbDWPKP9wvI6aLJylBVzt
         QVMTJGc2VQuS/fSDdpo1qPaE0Ye2ysICvIvoR2EnTHKyEBCLprVHdJ+mtNhqvyr3hj5z
         w1kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550099; x=1776154899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ycrS9FhnA0qDzg3E/0jewmRkYl3w3jvUXrSoruqoAk=;
        b=i1l9MpC3C7LcOfOYIQZdXgtxJRzFfhWI8dokGiQFbhhaUg2FC9MN4XzWwi1m6rWgAG
         1esDPDyPVL2XJISmKgRJYpBBqPh5KKV7bTTSLon/wxbiuYcGDp96BUNju5eWbcxo4rZ1
         lW9yYJtfaMlgrBU77huI1KB0Qny5Xih1R1cEIvlpaiVzTXY+MBYJkDB3vQVeYzE6jLik
         Z6okobiYuKR3df7rT6dKBtthEFHR3Ta+dynqwrqCkk0gqfnFvbLzyZzTmSjYWTfzpptH
         Jz+vYtPtCl77GZuEgsPuQpEAYpfyxqTdknFzaousQVByMjVbI8Jn4M8tYjiM9TzhyTma
         rogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550099; x=1776154899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ycrS9FhnA0qDzg3E/0jewmRkYl3w3jvUXrSoruqoAk=;
        b=jwJYfEJ5VP1mlCRh/F+kek5mYcnp1aDxyIjdP7pwpuTAjnSXFyLV45saIMgM+njvej
         4Nmg9iL+bedLm824ttjIf5GkstcQxOuTAXUfHyk2eTK7YGE21cx27dU8iD9rIGAZmgDA
         vUqsGmnGvQSFsMsiiVk1imGcks8ocfT6x/qFkgsb6jCkmTV9CWNK9EVoakFWJjbuNwSi
         cf12/UA7p8FrWjNocaDLZAULnRvRxArc1kzjYSBoB1HADq9QBShwUbt7+biYtHrsi+Oa
         kmIVwgg/YOVQ7WFS7rvSAFfqAhkWLRnKaWC2oGS6xCYpSJnsxWFZmr/Yxdoh20vhPnFe
         xhhA==
X-Gm-Message-State: AOJu0Yy6Yd8iNulVSaRRgUp+Ligyvdqd9qW4iDS6KP9zNhuXJIZ6uwTb
	wxMjEPCujoyPwvInQSLtaF9oUh03u6SjpaefxaVi7SJUsJUVp3UQaIlZHKEHyX+E9VTSUy494LL
	jlVCYIwN+uftfXrS0xS2ghdFLctPHruI=
X-Gm-Gg: AeBDieu4SmtjWpfLVC1s1FKN7oH+zAVoxP8KqRmdjEAkg74qNfvhnKDeQP5VCbOhDL2
	5cyWgZWQtsIlJKceLGaEQ/cjq62KYW0Ny+3CrnMZeh7egtcCDxRsQDGDKX6nZR45D0h+cDen8eB
	FXo3cDBkragkRya1XNchQBYaO3H4Wmw5fVCRBXGlMBgCJmbTGzg3bqwunSHNCNvlhXpeCK+MMtG
	2SDmSlpkJrJaYnNRmVlE/5S5fzqIoPvfyp1ZmNHfTGRnk2dmah1uwiohUBr7+d9KaiNk4CXLZee
	grwI7e7W
X-Received: by 2002:a05:6512:a88:b0:5a1:351f:8650 with SMTP id
 2adb3069b0e04-5a337550147mr5313415e87.8.1775550098819; Tue, 07 Apr 2026
 01:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775207252.git.wangjiexun2025@gmail.com> <20260407080015.1744197-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260407080015.1744197-1-n05ec@lzu.edu.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 7 Apr 2026 16:21:00 +0800
X-Gm-Features: AQROBzB-D1F9JHdW4USVZup4cY67fD997_vz0N5rqpF3YTZeHfNjY0XQCGJm2_k
Message-ID: <CAL+tcoC-_OYcwM5d0bpdGWBB80GV9UZYdsHW_G=_cHhzQW3gpw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] af_unix: read UNIX_DIAG_VFS data under unix_state_lock
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, kuniyu@google.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	xemul@parallels.com, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	yuantan098@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com, 
	wangjiexun2025@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,parallels.com,gmail.com,lzu.edu.cn];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 012673AB441
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 4:01=E2=80=AFPM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Jiexun Wang <wangjiexun2025@gmail.com>
>
> Exact UNIX diag lookups hold a reference to the socket, but not to
> u->path. Meanwhile, unix_release_sock() clears u->path under
> unix_state_lock() and drops the path reference after unlocking.
>
> Read the inode and device numbers for UNIX_DIAG_VFS while holding
> unix_state_lock(), then emit the netlink attribute after dropping the
> lock.
>
> This keeps the VFS data stable while the reply is being built.
>
> Fixes: 5f7b0569460b ("unix_diag: Unix inode info NLA")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Next time, please, you should obey the submission rules. One of them
is to at least wait ~24 hours before posting a new version, which
makes reviewers from all over the world have a chance to take a look
at your patch.

Thanks,
Jason

