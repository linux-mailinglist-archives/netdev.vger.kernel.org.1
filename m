Return-Path: <netdev+bounces-84138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73530895B83
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 20:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26230282C2C
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1515AD81;
	Tue,  2 Apr 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrrTfE5e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21D15AAD7
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081706; cv=none; b=bZsNTCMvT5mmA8MO7hXyHgkGRX9k+aNA3bqYGhG5ziKP1n0WM4YL+e5D77w8WuCCidK4ptG1RqzvYj9mkkEyLnDNZ73FUrv9KXnYWSjymFD8XhONJuumYlzLC068gVGg5sbY6AtnfvBCC3mJwpgNYcHOQcr3nCTMjK2oOKnYYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081706; c=relaxed/simple;
	bh=46KRqglWord9rtMJP1zH3v5q6uz/1865w6V7OrJf2L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4kRUM+fFLp0mUssnV+LYbEBNUe4CzMMWP1hJNeBkFh5AOOz/k81YBtmd63OMUQ4t65rhqKg0Tcf113oPXRq3GSB6JBP6LhPP5qB5KwSEsAYddhxZtvtHGW6tonh8tLJsbC0l5THzKkxsy4bk7iRzWBqUxlrWiMSSqjfgkVa4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrrTfE5e; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so24278266b.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712081703; x=1712686503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46KRqglWord9rtMJP1zH3v5q6uz/1865w6V7OrJf2L8=;
        b=QrrTfE5eHT9Ks7P91fL9DWFfHfSPMbXGPLy61CxZpOMOXgBWxr6K9tzWe7KV1LXtIL
         udB6dXq7MEVactyVz7QR1KUUbajVJ+MjxUDGIw51tVRm6QDeSG7+V04e/rkmQFJfu+cC
         po/iuhj8u9lncJwajFBU46fPI5Rc/XtxZamDbI1cHO4RinWnQJ/TFgiNtFEnKhdw0dXz
         YPeHgAwj8QB41RsA0p1iprvkWLRrtQdI6Z56jNtRs2YZXNj+e7AGtswL08ODqeYamH8T
         Xl6oz2QuH0fGXg2NhozatSLqwzp2v3nCEyi/UTXQ4QIMmgBYkd4fi8k6XBioVPldu+F6
         aYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081703; x=1712686503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46KRqglWord9rtMJP1zH3v5q6uz/1865w6V7OrJf2L8=;
        b=HjDLt7lVuix0WeKLoos5mCxBb3ioJKoUWaxK6EbyrvTxm5V8I90khe8D7DxdMn+dQQ
         HVt/yR7077wLvrwSFPmTMamZl3FTj8TnQJpZabtDMQJKzW76FPl7kJnwFgODvEs8gKpA
         Gl9a4PDWg6eZUG106D1upQcEHhq2sW1Lrwxvul0ce5lyUhR7ttLsICllo6QxxYt42R4O
         D0mlRqDvNmMs3d1cnup/iIgOJQYUclfBK6HN3mRxX9XkPVJD0zKKO9KzBaF1S3cIeasb
         IwmTw7AWqE1phJz0C7qF3llkiMs4MHlHqSJEIf2INkWTqTidyi5PDKEEaXvnEuhGjouV
         Vvww==
X-Forwarded-Encrypted: i=1; AJvYcCWwYjCHrQsZG7Tnc7MFOm5tLzamTNgy3Ip6OdYrKVDkHsZmW9vPIV7zumnaABDUZ7hx6F/WoF0urFHvOiQuH5F4kUU01IqL
X-Gm-Message-State: AOJu0YyWPy4LQeKwhmSJB6MH3m39a+ytL9ZxNMHAuhtA/qdw4Ti0T5d9
	CItQWKVUCSxhU/ThwpawATg5pY7qsn0ScIM+bL+s3sHiZVT0TNB19QDgwteMeHxwzZEAkDbqA5q
	pNJm5SzC0OOMdNPjDNEi0+WtIbp5vUYm3mdTK9xpTFEryF7oxqzAP
X-Google-Smtp-Source: AGHT+IHP5t0nrM9tmIdN/vj1cEcR9X51TIZOinjwJqg520IJ7wC6cLJyegvw1MPl9rlRhm9Xs3DTLyD/c/Q7svlAuPk=
X-Received: by 2002:a17:906:488:b0:a4e:1d5f:73ae with SMTP id
 f8-20020a170906048800b00a4e1d5f73aemr216379eja.12.1712081703092; Tue, 02 Apr
 2024 11:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com> <20240329191907.1808635-2-jrife@google.com>
 <007e30b4-31aa-41b0-9e19-f7e2a385773e@linux.dev>
In-Reply-To: <007e30b4-31aa-41b0-9e19-f7e2a385773e@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Tue, 2 Apr 2024 11:14:45 -0700
Message-ID: <CADKFtnScmu+57KURFEUG5s8Qcx6NfAgF1XNfjT+fSZNLqV4amQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/8] selftests/bpf: Introduce sock_addr_testmod
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Martin and Andrii,

> This function can be made as a new kfunc in bpf_testmod.c. The
> sock_create_kern() could be moved to here also. Take a look at the
> register_btf_kfunc_id_set() usage in bpf_testmod.c and how those registered
> kfunc(s) can be called by the bpf prog in progs/*.

Thanks for the feedback. I will explore this approach and see if I can
get rid of the additional test module.

-Jordan

