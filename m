Return-Path: <netdev+bounces-53938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ABA8054FE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72CC281949
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0956476;
	Tue,  5 Dec 2023 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="RgakGAYx";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="r5l5QQB/"
X-Original-To: netdev@vger.kernel.org
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D290D7;
	Tue,  5 Dec 2023 04:43:55 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 0512EC021; Tue,  5 Dec 2023 13:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701780234; bh=9k2hEUfWqSwjsOCNxJeHa/J+KeqtpWnpfnSOvtCRoqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgakGAYxKTHmfDsp3Xz4ToOiFec531bEiG1oi9xpE8L6ixaQmDIE2gEe/81AmGTsx
	 eRHIgxFTpoptfzdCWKjbWQk2QTwR+BE7qkNahj/nkWO0yDWFek+tn4VLimnd1J70ig
	 8ANst0jEIPDChSXLz78NnNS2OnIIuCtJG5ozAjrQejv7GqiBlf/ostfQGsn2/4pMIb
	 uXL10maFRsYdzr/npMZvI5/LT0cFtXCym+TKMh9uHo6w0O8q5QYx8xGm56uo1hiikc
	 TCfY9o5H4/3geFLUvnLE6+z96SQUa6eaxBbdYt5bwGz+Elje7NcBzuAiwIVVaCCMu+
	 4JMcN2RW9w02w==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 79FDEC009;
	Tue,  5 Dec 2023 13:43:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701780233; bh=9k2hEUfWqSwjsOCNxJeHa/J+KeqtpWnpfnSOvtCRoqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5l5QQB/eieudp+PT4SYxj+jH20QiV6viRJce+pCsKIvdchAaSSo6NJrm8mbpX077
	 4FfxkWQ1sekeWcSekEviSIJyQz6pPS3ChXg/kZtOFoWvFUV214ioLcZ3ymvXOOEFLq
	 TFdGCULG3GMJQkCbiNgoSAqnxxJ3Ula5kL07YimK58QyKTqWpFU8zR+2JHu0jHIKqu
	 QA7P8uGIOdPCs/vNM+ym0SuZlWDPdbLE5D+Cqwyr+JYnE+ofu4z9wcAaV00YcwQJ1l
	 R31riyGsVI5wQdTKV90vNKG1rZwuhw8h67zc4qzlX7UPuI5eSg1AF0Nwwfc70vv8Pw
	 9eWMwT5UxDIsg==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 98847857;
	Tue, 5 Dec 2023 12:43:47 +0000 (UTC)
Date: Tue, 5 Dec 2023 21:43:32 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZW8a9BvNwO4yw_JX@codewreck.org>
References: <ZW7oQ1KPWTbiGSzL@codewreck.org>
 <20231205091952.24754-1-pchelkin@ispras.ru>
 <ZW7t_rq_a2ag5eoU@codewreck.org>
 <2974507b-57fa-4c9b-a036-055dbf55f6a4-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2974507b-57fa-4c9b-a036-055dbf55f6a4-pchelkin@ispras.ru>

Fedor Pchelkin wrote on Tue, Dec 05, 2023 at 03:15:43PM +0300:
> As for the second initialization (the one located after kfree(*wnames) in
> error handling path - it was there all the time), I think it's better not
> to touch it. I've just moved kfree and null-assignment under
> 'if (*wnames)' statement.

Ah, I somehow missed this was just moved; that doesn't change anything
but doesn't hurt either, sure.

> The concern you mentioned is about any user that'd ignore the return code
> and try to use *wnames (so that the second initialization makes some
> sense). I can't see if there is any such user but, as said before, it's
> better not to touch that code.

Yes, it was here before, let's leave it in.

> > I don't mind the change even if there isn't but let's add a word in the
> > commit message.
> 
> OK, will do in v3.

I've queued to -next as is (with the i initialized as Christian pointed
out), will update if you send a new one later.

Thanks,
-- 
Dominique Martinet | Asmadeus

