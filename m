Return-Path: <netdev+bounces-277266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC1rJaOZ2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:33:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 296633D2CE4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D416301026C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F9386C0D;
	Fri, 10 Apr 2026 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wtaspdkx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362222DA749
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802711; cv=pass; b=RkzXFCGc0NtgIUeKnt0P1weQA04oPhDW30bYMpbVnsExcyiVuyov/DrQLMFJN3V60yXoIdbNyG/d+0AYxztfwDpas+wbm2RCRcZPbI/yCIN3mRduhFWs33SOS3R9GpNUkotdCxyFZGdDj4k3mjvfy7w9+HWIVRbka4pd1CDWb80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802711; c=relaxed/simple;
	bh=QNv3RhMQ22/HNGeiFea3mpb5rv6rCJ9wjpXVgU/MM3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSYLh01K2wC7t31Ti0lgeKczzQfWRTKVLG63EsdDxI/y4ByAFoo8kJxCjxN+ZgvqWGy/LJUAVBZFJDnRrk/8FXXXiFjalYNw4bdXakZnmVH8ohGzTGkqk+pfFnCMBG41iEBb5vou1TGQ4YhxAsM5s6qVAKb6/ns4huAmxAr6zUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wtaspdkx; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12732165d1eso10972896c88.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 23:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775802709; cv=none;
        d=google.com; s=arc-20240605;
        b=V55hEZ0E70kIWyctODhG08+N1OylqonPb0IgOD33mxOewn7cOWPT6WUXvj5uLnnU57
         camcuvSL9xbQBRMD5gUvpHAVIUQF32nzlH57AAs7jH2v7TxNt5Jf33bhEGB80EIOvuMj
         ECX+nHy/l3/sSEQiDm2PPPDAPVsx+/mqy/eDXga64p3Q2n0b/XMAZSFfK1CJQlgU+FSn
         3TT+qGBvTbKeeklURKlhpmHn2+RcL9HIERhUMtwu1qHGxpsjW/a69QDhoVl1H8c6y5Ms
         h5D/877+/g/NAeXEhsCq7DoDIu/sm6rvLUO9KpNPSqR+OyJ1+GRk315UIo9Qd2ueJ86K
         g5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNv3RhMQ22/HNGeiFea3mpb5rv6rCJ9wjpXVgU/MM3U=;
        fh=67ggfHSZH2p9EQrfh2IaB/fQJMZtyCRBL10283Dl270=;
        b=MLJXCalffSio3g0GXvo7qQBjoBYy67/2K8jp7EwiAaHJTRn+nVH19HrcxDVBxKpVOj
         aEh9QPzif466biv2WHMF9THfYHe2eL8gbdHni4yEgV3F8d6o+BtPHGmtvFSotyakgLsG
         sL+Fwp7O19tjilbOBI8WLDtIeM16UFmH1r8H/zjzyImt/Rf8i7eoBD4JSNPc649HN0ke
         NhTrzQVXBNnUrbli6ib9Z/LfiO8CWXYoCsmSsEerAMXwR8mcwl7GFEQRnVXXXorD2nXf
         1BO011XhRctfBzuLWkNr++qQy1xt7HRaSRPW0hio6NU5AfhpQIpHvi1OoHuouitYN1rb
         hNwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775802709; x=1776407509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNv3RhMQ22/HNGeiFea3mpb5rv6rCJ9wjpXVgU/MM3U=;
        b=Wtaspdkx9/vcBf79AFYMLvjDEB2yDlsDRwG49SpclNsrxpl4Ygcus4Y/SiVueLVcF3
         M82n8BdxhBvZah3jdkyvofzIoH4sboXAh/H6AWHIryo7hKb/dCooueBu5tV2PRzvTWQf
         yQFZVJAbCWOcTZcYrVAzEgnuPv1fKr425rM+E2cIH+7lykZtXgCeKZJeebDKuOwHyqHh
         +KryBrV2Xv7qI/gRlpHgcv8O1coQCaPuxxzEutOXjiL0Rvdxxbbia5a08W+DbV3i0FBx
         wo73MJ90sNH5zJTJGK0YAWoNRh2g19mCDX+N+yR3ojl/DxhM+z3jO+PzrLo3MZeHjKm2
         2eTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775802709; x=1776407509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNv3RhMQ22/HNGeiFea3mpb5rv6rCJ9wjpXVgU/MM3U=;
        b=lBLlsYi2syNNu68aSoc8eBaaB92agxHtKRDWmChZX7qvjCuRnqDMxn5+JrDTY7BVS+
         V2h6+5z1EayvP5OEB7WGRwSGMgSbYg287SWMs7zm4IvO7UTKhrze++o9OKiuVnibe+mn
         a+JwuGo1iHlHzk9ozMBZMf7uilSiYXXJD8+Yj02c0BAxGeoSYSnzGBKHb6JzlErXpK4Y
         CiWU16X9NyI9l2GSW/aqZAvnbAo3iNZYtEUfhogUAaAgMFMvETeiobazik4fmK+lW9RR
         pOpN+k3HVIfwNewEL4t/M3txdjwbydzno6ReLpJb8H6TPgbvE0gy/hOTZA/mBQ2ELNHR
         Dn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxDRN2AmowN3x/vlb39tX6MaigZNXOCVc6jmdXcY43r/0hiVyowg+kn7zqTiIse12fs+GBUyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcEejcRSpG7Szgn/l2qC6iowzRzDiqpFgtWIf7+YxK9vD6ky2
	b2JMuRJfMFHmJ5LcQkQ26XyXLqRZ6eVZ9VOsOKg+5wQrppasnul2vgmIOGYb2YVXI76CN1Om1Fu
	voKRMnZLfDlI1ApzaoFdwVH79cqdBgjcJIKttwk7W
X-Gm-Gg: AeBDieseN/uSIkW1WtzISdtAgbNisVvubceu8DFOz79tyC4WuO6r6ma6KESTVe0q5/3
	fMZGyenazfVwMzw2jrAu6ItyglOEPtc7MMx3C/tfpo8tCCeVGdZT04xJ4PdC75uylUYsegNISwq
	3M0kmZqsyH23Dp2yUI+yVqBwq/Jp+vc1xgDPN/L9OdRddWiareu5GFU/dnLLK7DVhfZCCgH+9Jx
	9E54a6vIQ/CCtiWJpyAuUI6pJ7b1qCcN5C/1wPfA0cyc4B7YpYuX6vQYykzdx9yhtQt8jcOob+1
	vTa8y8BNL14G+5KjVIjMrsWpFi0+Xru6N/gZx+Jj9raCLSuOsQrBeFWXHeaRnlJgD0BDSmbQSsd
	SHVIZ/OI=
X-Received: by 2002:a05:7022:62a7:b0:128:d577:dc21 with SMTP id
 a92af1059eb24-12c34e712b3mr1131056c88.13.1775802708539; Thu, 09 Apr 2026
 23:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-7-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-7-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 23:31:37 -0700
X-Gm-Features: AQROBzA8Q1_wQjFZKHsKZk5TChTM4zsOPcW8aryfLwg8I_KCeqgeADVGzy2JxF8
Message-ID: <CAAVpQUArYHi6tDXhdrDUnLxBGBZibKnqbOvRr0mJvrdfu8MwYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 07/10] net: team: Track rx enablement
 separately from tx enablement
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277266-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 296633D2CE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> Separate the rx and tx enablement/disablement into different
> functions so that it is easier to interact with them independently
> later.
>
> Although this patch changes receive and transmit paths, the actual
> behavior of the teaming driver should remain unchanged, since there
> is no option introduced yet to change rx or tx enablement
> independently. Those options will be added in follow-up patches.
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

