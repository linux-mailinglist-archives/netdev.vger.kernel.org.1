Return-Path: <netdev+bounces-141299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C809BA67E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE87281880
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4003D17C234;
	Sun,  3 Nov 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qWAQLDDM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155AD171A7
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649412; cv=none; b=JalFgx8y+LAiVXqLP1Itq0SgUamEKwcfGklQPvvOopXf/Y7yPE+iEUJ6IkQ+lWBArLx7G8yy2xPgw0bmiPuOmCDbHR05cVOP/sFMA44N4Tr4ftMOLec287ugYfhM5pTQK8OTQgVHkJl5YPibwzYno411JBe7q7Z6xOTLsUGMVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649412; c=relaxed/simple;
	bh=uVOvzmrL2uIusu39TcWvWL2OuxpPp/4jVn2IhKZtRzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jn0za7JBmax+Wh1R2d/6WrG8a8isA/jjMtF0H9hNJbd923ugPfUw+mDL2o1UGanG6EmXCVlCd4GKgQS/KqIGIgvI/cCxqx2YGQjcuGfUito6WpUJqo9gq/lOJXYXBSN+Tn9dVa7eFNqXBQj40LK1Wp8T/Kr6ntf+lygHBcUQtNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qWAQLDDM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdbe608b3so33788445ad.1
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 07:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730649409; x=1731254209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWoKw7vMI1rbINkCOXeNFSSiNKHto7EpBf34+HGBMqI=;
        b=qWAQLDDMThA1GZPB6MreQ2F9iq5aqlDiZ0SgZdNIVsi+dbeU/o9PioNpPdog5Rlydk
         yVpWldIYmMMTuQJyRUafrMEIV+an4MIIuNU5wePjCPhrYSMgrsKY2GuxAM9qsh+KwEOr
         A1cBQTGs7Bd9c3HlWz1oJablwoNZZmco0fc4tGuK4maEO/JS5WCG3U2DXk7eiaxM6f10
         GWjC/BsRpZkboVnHcycTPauH19UzPP6MexhbPGumvhKxYDY6OMfIh0Utu0rDIfR4cNMv
         /LlS1I8+DNHGPW2zLPLx7DRHM0dg3w5uyGUth5m+6IZG/DSzR5/Q+Ma9xSfuE6mlHo3P
         GFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730649409; x=1731254209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWoKw7vMI1rbINkCOXeNFSSiNKHto7EpBf34+HGBMqI=;
        b=N6B+NeMuZa3r5g9rLer77wrr+piXiVj2JFHvgG8m9m8DfLjXI+3oUltwX5Ub0VekOl
         3NsjmwD8Fgjmv832h88wCF+PZf5OQAWwuOU1KyFTCLgZFonN+M4Yz+ywF7OUxXdtyncW
         SrdHZFeWTJlIMXoipHecArx8xUgjIxlALxisaa87TQ92RfQ0TwZyeRxUMF7lMZX5Ah7A
         /j1BKapL+Hf+rf7kgNCsOs6cBJsD9ac9ObOJlllGNfxHzYtIkLCiTi1IJK+a7BZz24CS
         +ygrCKU+laO0ouheKmJtozYnyr6d8qFQdiMxS+Eann2xRJKESyLx0Udzoa87SyUdCcj1
         RFeA==
X-Forwarded-Encrypted: i=1; AJvYcCXow6epr3YMPgUTceAJK8aVklT3RPLnrSs77JCIe/AAauzkZLyQnLGQ88cU/wSM9TfV22MNfSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpRXnPnNAz/aR8XARnu5rlDO/MEUtzV/jEJ16mrEeWLOp5/J6
	BOGcQvk4DsT5husJpuAoEP430TTX0bmKeCmOqTPOwF0Aa3pCt50pRtn0NTfv6mYmEuDwzM3w8LW
	j
X-Google-Smtp-Source: AGHT+IHdkpnsKG34/WhfzO/ZhrAAIRqj/1Sq9XfhRTB+2YYyA1OkqIBl677gzzjYRbNN0C4njw2pbQ==
X-Received: by 2002:a17:902:db0f:b0:20b:65d6:d268 with SMTP id d9443c01a7336-210f76f53eemr242270345ad.53.1730649409328;
        Sun, 03 Nov 2024 07:56:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570815bsm47320175ad.91.2024.11.03.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 07:56:49 -0800 (PST)
Date: Sun, 3 Nov 2024 07:56:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [iproute2-next] ifstat: handle fclose errors
Message-ID: <20241103075643.03cdd7f9@hermes.local>
In-Reply-To: <20241101110539.7046-1-kirjanov@gmail.com>
References: <20241101110539.7046-1-kirjanov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 14:05:39 +0300
Denis Kirjanov <kirjanov@gmail.com> wrote:

> fclose() can fail so print an error
> 
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>

I am not convinced this is worth the effort, especially
for files that are /proc.

