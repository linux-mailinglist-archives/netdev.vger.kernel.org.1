Return-Path: <netdev+bounces-85234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE19899DCF
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C34F1C204BF
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CBE16D322;
	Fri,  5 Apr 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkXAPku8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221B16D4D3
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321981; cv=none; b=D9PLonS0T2OY6Rtoir7bSMzjV2O1Ew1HVRKiTL8nNqWRBTHb6SBOC+guhiFmYsFN7GYvJfB1ouLT+qdE5sHFYGeVp1oXh4zhuy1FF2j4u/ovez0iFOAYIMAcfv0KFz85qCcQ1DenripiCcBBbh5VmDm6cAc8NzhZahmSp/uH4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321981; c=relaxed/simple;
	bh=HIBq9mFl5ByRg1Eql/iX9FsUJ9TNtZrqA5vn4PmCdkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrlCdj1fcq6VrIlEH0DvDum8ZteqfqJC54DQcEZdW1PpWr7CPUBoUOD5GH9nx8ct5fzWWElxiaAxvzAGb+hif7Nn7oIqdK9f2Nh6x1VYuUhLcVvfpIaj69ysYdkGn/IXUjqvlqk/qNmzIx7WZEe2UYxd1wlQzVUvoIj9sgZBfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkXAPku8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e2b3e114fso1137233a12.2
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712321978; x=1712926778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIBq9mFl5ByRg1Eql/iX9FsUJ9TNtZrqA5vn4PmCdkw=;
        b=CkXAPku82of8nPbM1ymhFftwhr6CReyDZ2fwfrBAnX7pE0uGQWxzx9TByTjYA3qNzT
         tNlV/uAs3Z+uKSTvAoudtO8FmoQwYbStFkKW7P6N1Ah0TXG1y0fnhbD1HWCsjzkExLTz
         y7ucosAapOzQhQS+QLhy0wdQKeJSJ4u0eq39PIHSWKnXA7TjBxgq59/WnRo33VAid29u
         8oJ6cBecjgZKd+1ECOkS/vj94n0+O/Lz/cDf0gZUqC002QPCvHWvudujg4rs5rFiBZpq
         Um/MwyQv/+rHH7pgbuKmbtUQkf+M5MaISHCl12iF9ux7TZHcELGWv0AQUHPYcUe/2fj3
         KrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321978; x=1712926778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIBq9mFl5ByRg1Eql/iX9FsUJ9TNtZrqA5vn4PmCdkw=;
        b=j1MRTjYYx+J5PDlWe2QmxWRPF/WfrbPQrnS7g5uR9mah2UDOlDVr0e9xJDjL7SrjmS
         187JH8LPTtsbKb7bU+nR4b1bOFJzBED8skZKCN9Sn08JpBHViomLyUqzI2JF3qVI1Ebz
         hHEm+ii+vjkdQfKDrxeYOtzWAo5qZUQYwndhJAw5j/rfdDj4Gj/S9QMC1SoMZ84te7L/
         fptaFiSzrvqfsJOsJiwuf10ZM4wdXLOK2/BOMw9mOfHZ1kQP4SmhwkfN4ZykIOanEs3l
         LjL57w1F1EJj0R5+XVxEOBZcrM1g4t75SI9Md3uPQbD567lnSchliVzRJ2a1g39d04XO
         qdTw==
X-Gm-Message-State: AOJu0Yz+X1ZDRDrpIlCpySq0Yp6SofEcDhD+WQ3mPDp8lJwVYMl4pLP9
	tWvn25x+AEqiVOERfhjiMKkS3H+/B22g+LgovknVtQf1XjtgnkLj
X-Google-Smtp-Source: AGHT+IEgbePR/L50EL5CJ8JxZiCVYpequPRTnIkRzynQXiaRJSTSKzNDv4o7/i6U24VqvcHJi9NLpA==
X-Received: by 2002:a17:906:a895:b0:a4e:26a4:bba1 with SMTP id ha21-20020a170906a89500b00a4e26a4bba1mr977823ejb.14.1712321978122;
        Fri, 05 Apr 2024 05:59:38 -0700 (PDT)
Received: from rlozko-msi-laptop.pine.ly ([62.204.72.254])
        by smtp.gmail.com with ESMTPSA id x1-20020a170906134100b00a519ec0a965sm807577ejb.49.2024.04.05.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:59:37 -0700 (PDT)
From: vient <lozko.roma@gmail.com>
To: lukas@wunner.de
Cc: netdev@vger.kernel.org
Subject: Re: Re: Deadlock in pciehp on dock disconnect
Date: Fri,  5 Apr 2024 14:59:35 +0200
Message-ID: <20240405125935.189797-1-lozko.roma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zg_MOG1OufptoRph@wunner.de>
References: <Zg_MOG1OufptoRph@wunner.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guess you are right about 6.9-rc1 changes, I've booted to 6.8.2 once more and
dock seems to disconnect fine here. So the problem appeared after switching
to 6.9 then.


