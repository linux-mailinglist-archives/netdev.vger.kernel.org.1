Return-Path: <netdev+bounces-253432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEWvJz1Qd2n0dwEAu9opvQ
	(envelope-from <netdev+bounces-253432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:30:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07A87AA7
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C67E1301904B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D82C332EAD;
	Mon, 26 Jan 2026 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uB7yLfQg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8F2BEC2B
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426865; cv=pass; b=sfBQMVhRfIGwLQm2mUdps3K91X0mMgKt/pOTsHdebgmmK0Og1lkKq/oG7EdELPVt4qT+VUA00U/E4fRLDdU9XLPy2fXQ3grvcHkm4xYTJhTXK+CuwAeKc+Hcn2plG1WMOWejhBlOaqoKDZPM/iuzYfPR/ZwOgrcczqDlRYhopAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426865; c=relaxed/simple;
	bh=h8ZCcckMG8vMv/qWBL4V+ZodbIVeVbJiU80VSscs6a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyCsHuYMmy0bkGNlCYApl1hDRVckIK2HaYTF1RgF/frBlhsApnAfIRgEuphHTiP4VlofFfhd1FdYsclL9u0xqHCVeDFnRLTG//dXm+Jo5oettDPAKCXYTa9hFC0Ed0PANx6X3GfLqcQRdk6YEqNkoUB0zjAIeFSsAqVPZu2xyzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uB7yLfQg; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c5389c3cd2so518100785a.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 03:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769426863; cv=none;
        d=google.com; s=arc-20240605;
        b=fxAShtYwk30DI60j8DqdwE0fiEu/TGxoZnAKUU+kEf9oNvSrDTWba06RKIqOD9l1Cr
         KKSGUsRpaZwCF1piK9tCDIVFcDTdYU0wGwJgn+yVSlgQUrwGHq2RegdtD8gmPqoci/V0
         c2tfgxyrYhBf1qZUAQHxSLB1Al0yvsZzDihCvieL4nkr8ft6apNGjSoiqfItVyirw4Af
         GZHsmnCnH3OJXYno7ZMYV9IseTwFK+/HSDq0y6KjgIy69vUoH4B+ALi4BgqIzht1XKHX
         Mf2SR9f57vr1empQoNQ+Aijh+l4RHH2hEUqpkfm/jZ6UKaGs8oh1h5TYFwEmanYkw/oV
         J8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h8ZCcckMG8vMv/qWBL4V+ZodbIVeVbJiU80VSscs6a8=;
        fh=6B4lTAo21welAIsGWjmPdUtbe2vCaHC1jRGrm9L4R8g=;
        b=JJJXoDlnagmJ+F1eeu14AESj2xKjDtMO6XglP+ebeVwjH/BN9MTHv3OXozBccvJU1j
         UmPI6JfNf5Zhh2YHMoEhNIXUDMpr66IyOsbZQE2MU/ZNhYXTSWma9uMTjINtlHb774sG
         TczbB0wlHC2+DCcQOOPHWecCk9HuG7hEv4Feaq84zQ5LhKOqWqlZYJZPDEOPO7CfXYTe
         FH+lHX/a22HF0uZta1yDW2jvE8e2QIR7oxuSbsKr/2U/EzkJ0aOzbtvj7XIlYXzwq7jn
         Qere1WR0jbeToIX6P2BvwCvxAYrACNlXHhEZ8pTPcj88aZrY6DZ854G32TKGGExKJ1WD
         TgIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769426863; x=1770031663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8ZCcckMG8vMv/qWBL4V+ZodbIVeVbJiU80VSscs6a8=;
        b=uB7yLfQgVRveLrkvr8Q8kzNA0s1D56GwA3ky7lH10wsadr8F2IDPzP6e6u4Uzsh2uV
         cngf4c9TJy0j63LxSdnQp13SVfwTdv8R5Y9Cm05ESWynuirgFtdMHVJqWyUAWTaEqdpu
         ukLWInDacI5O6YKB8onHMoox69/YNWu8OW0cjHUdOpmLP3oSlCd9TCedSPKJHqW+a20/
         fLGg+1kd3h2Zn8yzKXv/VuO6pRPpdO7TN7QLhHQMpHYY+2LZ04cCVs9MiRbrxbUoftWk
         JT43OaCuuqp3xl+R2yPQJmmUUb0BkJsbbInWC0G3wgDUM27uWu+rVt0Hu0bs1dVngxj4
         C5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769426863; x=1770031663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8ZCcckMG8vMv/qWBL4V+ZodbIVeVbJiU80VSscs6a8=;
        b=v3gCV6+Xsdmxls0jPAZahl1eqXugWcGrBeNCY/jbngw40ZsBZykJjwYwXEPvTvWRiL
         5EX3vTduSyUFZAmpr1tgV18uZaKunQpnF6BHR1XiRLdefcqj4cVQSqkQeGd7AXp8p48A
         QgQb850TjExhMEDePuFt4qAeBdoMz62IjEQp/hUM2vcrM0ZwTQTgqzgMU4M6Qdo254bI
         MuvEC/ho+6hwEWEWssraifqqhTysRYc/Ln3DwYWD4x3kcBnqmFNBnn9shneYFr3TywfY
         +rW09x6qpQiqvPDJQfeKmQ+xlRhf04/dWhRYSb+WbByu5BW0qQDpjLuZ867ptG/dba+d
         wFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdXhws0O00I+x8TUR2dCzMlDLSwYRgh+hfmjNtUyd5j8qoFILeCwsQIq05cAi13QajQeDFP9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Dtnj/aOjZEN0LZuvMJm/Yvv02TP4XAE+vyZU+15FMpby50Co
	HM4p2hSYc6O21xx31JMRwzTEn6sBDn61EeGgGpZGSCnAvqLrjP3qWDLL9tCSuWrZ9eCKdbhPQVB
	KfprzxOrXQ0VjKZurrdp3RGkV6QYokc24RK9M1/tn
X-Gm-Gg: AZuq6aL4tMakjAK7DAfh8wTUyFF6LtSWMslX1nF4kA0Uda26E4W8fQuSBc+mgHraAyB
	phsGklP07gAdk+72TaFf8dVF1Z9obzRnuIkuTokyaVOwkhemAukmW5SIkhPMfXkIxqfHZf0P5O1
	UBpR/Nf9Jzc1GEgVUcEYIVj1HEnOqqLeXTkIZWqqdf/+WaYMUG17JZrwMjpgLGO+Cb7u1os8ehK
	mqNQT/nCZS6mjIxQVOK+7Pq3zA8O6aL+MV9Ru+xGTnRep9jU9dytP2HsZtovBxstzLPKlHM9tpj
	ZnZLUkk=
X-Received: by 2002:ac8:5fcd:0:b0:4ff:b2cb:a44c with SMTP id
 d75a77b69052e-50314d1403bmr47960511cf.83.1769426862667; Mon, 26 Jan 2026
 03:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+pyHq-jfqoaXpk_07LVCn+REmW1wPTbKmxV7ykZCEHfg@mail.gmail.com>
 <20260126112451.1071143-1-realwujing@gmail.com>
In-Reply-To: <20260126112451.1071143-1-realwujing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 12:27:31 +0100
X-Gm-Features: AZwV_QjH5TGn5QXkI_NLA6Qxao5bQVR3mwcalvG1JDFOVmGceieHRqQTrMyzS3c
Message-ID: <CANn89i+V=+cOv_Qs-VwFqt0W6K8VU0pFh2KWtDPes1Cw6wa4dw@mail.gmail.com>
Subject: Re: [PATCH v2] netns: optimize netns cleaning by batching unhash_nsid calls
To: Qiliang Yuan <realwujing@gmail.com>
Cc: brauner@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	yuanql9@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253432-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F07A87AA7
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:25=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com=
> wrote:
>
> Currently, unhash_nsid() scans the entire net_namespace_list for each
> netns in a destruction batch during cleanup_net(). This leads to
> O(M_batch * N_system * M_nsids) complexity, where M_batch is the
> destruction batch size, N_system is the total number of namespaces,
> and M_nsids is the number of IDs in each IDR.

Please wait ~24 hours before sending a new version.

Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Make sure you address all the feedback in your new posting. Do not post a n=
ew
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.

The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include a link
to the previous posting (see :ref:`Changes requested`).

