Return-Path: <netdev+bounces-275653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPCmHqnl02n/ngcAu9opvQ
	(envelope-from <netdev+bounces-275653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:56:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E61253A57A0
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388C2301BF77
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 16:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE9338AC76;
	Mon,  6 Apr 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpi15DjI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECAB2E719B
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494533; cv=none; b=LwpfpVlH58blMXVZaAqs9l6pDXp/bOiidMlZQlxT+0gAzQaB3FJPmEPelVK4KpJzFeYb5j+DNBENip9iE+yFJ3M0ZkqZG0gXTMKvkEeEqhvuk3VYqLXVMcg2vbzoSArd3v7N69eZOYpG5jzogRJC2qNqAzhIUwZj8BdrRH3WcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494533; c=relaxed/simple;
	bh=AhIcYDTZ8B/QT76YJt3d1yF9TjjC3ELrDj5iCQtiGMM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZfrYi5kR0Aa+FuC+D97Vcn8nzzayzt13WNbTbzZKaBEzzsQAvL1xNa+w59YH8SktO9CycVOVYKYRrt9tMaHEQN+crtNzYIiRv8YixfxOCKgmYESrqRgZ6MHQhJmDsrSfFr/FmouboE7xRL71ERCOrMNjMydqmzS1m58OkBEaSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpi15DjI; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65005a8840dso4032526d50.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775494531; x=1776099331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovA8BbQpSFAe0BomPFk/ncZI5rujFgTwrdXPr3HEHAw=;
        b=Zpi15DjIzRYHpFn98RKFs/plI+4KWk+0Fbx77Pe+tdDMmCI9CZ2hAig+wGr/7GOqS2
         TSlByUgYwPnWxPtJRfBsbawiWpTRNS90OikTFJrlxLMNJxWMs7qgISkmLjrKxZFpckGh
         qQiyiSYAuBRQMKyUfU3V3tY4X5IKq1fR1c13BFUFtHgysLkfHgNVBRyf+WsKlroIg4K8
         aWakUCr3m8CL/FCtlRuiv/NEEwZDB9huaDqHz5Oohwv7JZDMISfSP6lZbOVREQ//auAS
         EPBaRpmQ7NvPK1M75jW1GzQRwMREFPU1+a4YPGtfWXjBQJGpG1KdjWRp6EDJqX95j9ZR
         vefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775494531; x=1776099331;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovA8BbQpSFAe0BomPFk/ncZI5rujFgTwrdXPr3HEHAw=;
        b=XnSfon0UDtdfAcCgGz42paLiSMCjbGpalPALSqJJg8ExYhQApicvPCFK2ucYJ/Qbty
         XRtUWvfXkvfobaz3KA1tHPRzM8Btd8hEN44xn7JzqMmwrWR1dRU1tKbuYtlKMnnhDTU7
         pcqPcrX67hP0DBngA/g1IV6avcLF+vbtlmRsVY/tlt9b9ZGjgEAtjFyE9MVkpl87CUPp
         Hjqh5hd0zlx9NnhZn9tuR9LXSvxUE6XHFoIBgFwTptZbwfm1z1plAbeto06NOljDS+L9
         6ea6ekuw4i59ZMHc4jfmNOSEWyChuz+tVIEv8xSrkCrL3k7AIEcs8XuSz7jPkpxh2xDn
         vKmQ==
X-Gm-Message-State: AOJu0Ywy2+eGwW4pY/4yjI+C+qD7TupewVgt8e6yFPAF9vucBrt8dms8
	fQI2pk+Z99a20hdVuwlUOggZVtinzgnV+9HXawlxVbTwYcOG0TjHFhJp
X-Gm-Gg: AeBDieudaytqBFjMMhq8nez7f8FzS8u8aoHd5wAYtMXF7N3cDlIkF9nc/v87rr2DHos
	OUjryNnt5HqjvTelOi/VXSeNaBKQeVgyzNJV4j5eOYszk611mcgyMX6qdtsVK34EBhKvPEh/cHc
	UyHzrZKNEglHxyqhxTbtG1w8AlVKXKfdGcLoubsC3zNAAft2nntk3M5m1glPq70oW1UIJuKddDj
	W3+tb9hmmE8rG2MMrHO5INBQS7WlaEEP3UYIZmQGOB4+TFVI0T/8/TBJaionNrJh3ARUlTp8LKq
	8vD5ho0NmkiNxf3EkRjfEZFRHKdZKz/n/VUEx9v1bIBHsHLKXWSs4vIN2U2CQbxvk0hQBgZlTsq
	Bl0CcpeYMFC5ErET/I6ry5hjQD1Z3aVt8oWmPHDkuH7F0a12wmiXpgoy/Xcny41Hb8FgXp6OidE
	qnrm9EuemYHnMA4fdj41fSoKEcCs420l0Sld6ItD2IrDyZMNVBbSasRUjagSMEJYhmeiVqHs7Zm
	72M
X-Received: by 2002:a05:690c:338f:b0:79a:b0c8:da98 with SMTP id 00721157ae682-7a4d32e4846mr127476727b3.8.1775494531511;
        Mon, 06 Apr 2026 09:55:31 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370902c15sm55384667b3.32.2026.04.06.09.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:55:30 -0700 (PDT)
Date: Mon, 06 Apr 2026 12:55:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1a194b4fc6bd0@gmail.com>
In-Reply-To: <20260406090231.63df3fac@kernel.org>
References: <20260405014458.1038165-1-willemdebruijn.kernel@gmail.com>
 <willemdebruijn.kernel.1622322e50a5d@gmail.com>
 <20260406090231.63df3fac@kernel.org>
Subject: Re: [PATCH net-next v2] selftests/net: convert so_txtime to drv-net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275653-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E61253A57A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> On Sat, 04 Apr 2026 22:20:15 -0400 Willem de Bruijn wrote:
> > > +YNL_GEN_FILES := \
> > > +	psp_responder \
> > > +	so_txtime  
> > 
> > This should just go under TEST_GEN_FILES (sashiko)
> > 
> > I don't quite understand the check_selftest check_new_files_makefile
> > failure.
> 
> Glancing at the code you were missing the 
> 
> # end of YNL_GEN_FILES
> 
> trailer.
> 
> Those checkers are equally annoying and easy to run locally, they
> take a path to the modified file and say "good" / "bad".

Thanks. Indeed, I only learned about this yesterday. Ran it before v3.
Was super easy. Sharing for anyone else new to this:

git format-patch -1
mkdir /tmp/patches
mv 000* /tmp/patches

cd /tmp
git clone https://github.com/linux-netdev/nipa.git
cd nipa

./ingest_mdir.py --mdir /tmp/patches --tree ~/src/kernel/netdev/nn -t patch/check_selftest

--- output

Saving output and logs to: /tmp/tmp7zb9n8ka
Tree name unknown
  [1] selftests/net: convert so_txtime to drv-net

Series level tests:
Patch level tests:
 check_selftest                  OKAY    Good format (5); New files in Makefile checked (1)

