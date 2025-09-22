Return-Path: <netdev+bounces-225248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCC4B9122A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A7217AC51
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D131D3081A8;
	Mon, 22 Sep 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkq+RnKT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69581305056
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544459; cv=none; b=qlBiLWyczNGEXMKQ0lyMQQBnfzQcGt0GK/To7tgdLWqctOzMcRAMc/u6wqWZo63GaSCuIyULM4dOp2zcZE27pMTA1/2M/QORkI4Z+cuNCtKK/X2KJeztuWV3cVMCt6YL2vTCgpS8mZpqMuAawjM8gaSMIg3pTWIzFc0ladWv0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544459; c=relaxed/simple;
	bh=vbd/dIVFJeMuDWZGTwJ4IGGTJIynPy2T9UsNctLcg+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXNuWVBx6HmdYzIMCbRrnk6uvyFrKiiARsGSOQ7p97bs2bncMABRs6uX/jaS0SVpWorgPH7RKBG9xWFsQ73eEYXixcGdhMy5XtYQE9XF8w8vkGlrIz2yEe7bw9hDrWFTPqMr5HNDQc5iF1vOy7NiVuTyoujeE7lyIjdI9xztO9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkq+RnKT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77e87003967so1386876b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758544458; x=1759149258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7N/A/nDdO81iETqklo4zlY9UTRGuYMbbXYZaKO6LOQ=;
        b=nkq+RnKTOX1QmxxtADvxvCnTCHZgGC3811KoxN9P+SI4O3VqEoFXndehbJLEysxtsW
         0sRGXlCprFdcJNLLqZb2vDlw9S7q6SJcrBMugM+oCINdELZYG/yUYG5KZ2hY4h2JniVL
         ZLloidt+MuZI4y9xHQkiNG+kl+RshIS8MMORc+ZWMzW1JaQW0WrEDlfUgB3p4O+zhwjZ
         0i6GMnwUwRW39of/TGxzNa7y8SmqQq/zvc2jdQ21Y/VDFdHxXOLYgVTWRpRQzVtC7/91
         pgXkukd9RtKJcHRiI53qnTmig13KuKBRlx50gTcWh+dgDI7P2rfqRDgS0R+k2li+yjS6
         56Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544458; x=1759149258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7N/A/nDdO81iETqklo4zlY9UTRGuYMbbXYZaKO6LOQ=;
        b=i7OtwxGxK4RWbaF6uWeX+hk8aII7cyxDwgth+wuCk7LtjZJMVRkhvP1jpTpzuAheYJ
         vIdv+U+YYn31q9UMXokuzEqpZTDBr1BifdhTKknU4PeXSlQAZv+wyX4stRgWqtM//TGd
         4hjNIDKZTFBkhW0LbKASqK8pOtNZdsBozgveK20GaBjut7eyp1NF3hIMqtrBXXnPSTRn
         BgMq3BItt0liZ4D/9DWdxwrBqQpXbrTCmc3YUcjCi+iMhZXgLo6m/IwFYGl2wu1BHrh8
         wvBM7KJSeCfqmpdLLg9+bze/z5ij0OCoArhdM6cM3fwERn3+1IaRmjlC1JZbnskr8Ukq
         H/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVp3UbJ5UMQo78hZzQp8t3tB+rdmRef1klcYvg9DWZgsa9WHevH0Wwzua5U0Nvj+wbjWqG/DFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQhmz6UJ5E3MTV4coq4dbGc5r0thzBTx6qVEOdUmQIGe1wBJJ
	0E0Nq3xQAcq/DuiU+otGadeltoKogA+YT3g4v8lLxYsvBn5x6Mz5ykXc
X-Gm-Gg: ASbGncueS6BIasCX9r4nIybBaHffIZJEqAOvf9QlPTQA0+krVSMLRIZPInGGtnHvnS2
	g2/FGrwuok2I5XzLw1lxtAZlvMQxbohMohNJGd5wlZvwij6wUssQFqcgKULTkspckEH13n1HjN8
	q+UMVauELb/ItV26MqjGgVLLTA0BOQuJ9erW2ArMrAgpgQpLUtnj0EDW9/x5WIprJhU1MsyfvTA
	X0vRAjpnKbQwfH9kjw+t8R9jjW6UBxwN6UPJWLDzeU/AOhlqKVkqnLNfbH+2BNuz0+e2PgToxVk
	xre6N6FQZyHg/5f38mo0hZKLT1fMXn/OZJS39X/1EqWGplQJqXCYl+VuK/7IIVdzdANKp+bJH+G
	gZUch0fPyjC4KJkm0/H/ITA==
X-Google-Smtp-Source: AGHT+IHdWuuU//PjNYXcYLakegZtFFcQb6zpKh1LJyLgmx6iYUCqAqcadaDUiwNWxci1/ojb7D6lFg==
X-Received: by 2002:a05:6a00:3c91:b0:776:1f45:9044 with SMTP id d2e1a72fcca58-77e49f0742fmr14342835b3a.0.1758544457581;
        Mon, 22 Sep 2025 05:34:17 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f363ed5a0sm3251366b3a.41.2025.09.22.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 05:34:16 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 606834220596; Mon, 22 Sep 2025 19:34:13 +0700 (WIB)
Date: Mon, 22 Sep 2025 19:34:13 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.og>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux AFS <linux-afs@lists.infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH net-next] Documentation: rxrpc: Demote three sections
Message-ID: <aNFCRVGajxlZjjxa@archie.me>
References: <20250922100253.39130-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922100253.39130-1-bagasdotme@gmail.com>

On Mon, Sep 22, 2025 at 05:02:53PM +0700, Bagas Sanjaya wrote:
> Three sections ("Socket Options", "Security", and "Example Client Usage")
> use title headings, which increase number of entries in the networking
> docs toctree by three, and also make the rest of sections headed under
> "Example Client Usage".
> 
> Demote these sections back to section headings.

Oops, I misspelled LKML address. I'll resend shortly.

Thanks.

-- 
pw-bot: changes-requested

