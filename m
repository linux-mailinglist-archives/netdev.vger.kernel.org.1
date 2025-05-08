Return-Path: <netdev+bounces-188948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5081AAAF8A7
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D057AEB15
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA021D3E2;
	Thu,  8 May 2025 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuLV3o++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324871C3F02
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746703276; cv=none; b=GWOTZDpyE8DCXsysvog2zYlU7WlNYXp/0i66dkRpjhoFctbo4/UCiMSr5Th7Lvnyp3KCu2efWpi7Y8g0rCx5Gd5+roR5S3kTMbieMoJ1PnaR+bygaOxrFOP4dg0EW8IJlDfJjSUXjeF3hONhmPb/ny37xJe4A6O59gZNVqjY89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746703276; c=relaxed/simple;
	bh=A3qx6E/jCpqYf4i/M6+ll2towAT/4y0LtCLU37VMv3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmcA4tvc3KyCpuylF9yAqdx/yxzjfw4Qh64RGqm+kYqnZCC+YeeA1/vmUKGNwa7c7eylJeWiXcal5fOzGi56/nzJvM2WSBsLzH8j4KvA1fI7dilrOCAPhYiQZHuNPzR5C+M9YmyRKqoNqrTKDv/MNP6hutepVy5XkPolsWPk83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuLV3o++; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso503444f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746703273; x=1747308073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHxqh7UcluosWIW4kKSeGdafk8w5yhUEvHvez8ibNfI=;
        b=RuLV3o++Wu4RZUUsDoSWZOBI/KYamT4TNEm8YMRKRKh3DO8fH8bZoGG2dHAtzNw4mx
         A9e6id2cu86fBdIDVLkLDI4rHVoRXNcueljPCt2gFGiDYIaRd9O84UmDgovt3IhQwJH+
         Yl+fKzBMD5RZE/GuLFOhLbj9e+GGTRrsKV+KGZCZxc/gea0hItb3oynzh/dLbZw/831l
         4FiQ+rZontYrLTDoq7PBsc58olZKAG7nguqhJp4FQvt7xJQbmwfGUCIGVdybc2cNmL7m
         +WYlNTvvnW3hLrR67va0UDBIRiP5yYATq/444lEFfMdKSZ3CUzJ6kc/7b6mCX0fv0u4r
         aYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746703273; x=1747308073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHxqh7UcluosWIW4kKSeGdafk8w5yhUEvHvez8ibNfI=;
        b=QxHzg9jls6LItfS+K/h9b0qk9YhzDwdPRwTZ7nETXkPC1ljFj5mTtVR3tcasnVb9Cj
         5iG+czeDr+n/LgZhiiqy7lHMqKuRKETUJUCwtbXIoFV15HhBs5lOOv5bJ3yAf5whsSM7
         oVHkWVhB6ieMEgv+kccil7aIvgP6tVs3vkasHZcKubKFRfWQ46JmmiHnQ/9UzHqodiMO
         XcQCWVCkPUGWX6a3xqc1TJz1LP/Ebfmocp0SKgA8JNgk+lvctlf631LORSM/Fq0jgcg2
         yjBDJP4EPZ2JPKXvhnL+acwlQTz2Wo+/eU+tFfIXcPtEHYytjBfR35SdAdWL6i1x9tfR
         rYfA==
X-Gm-Message-State: AOJu0YyuVWBbsj9mMEo9a3Z5qfObblFrekmLtJ9tIeNwHOLbzon1DgXf
	YGxrAVkV51IST+mMp60bQrB9wFJOuuoM9ffMazEO+MzAvU003yFZOD7CEg==
X-Gm-Gg: ASbGncsg2dBa99yUw/hBt9uPXpXIDkl8wMWySH2M15ftxIkfm+OnGD5mHN280UgNrOP
	1NG0oVnG3b3/vWGdc4vIqM98dvJ6c8uM0zIUp/DotiMVVqZ4ivqYg9GDmemLP3uFAeJcYocWGuf
	OKdJtXonAGMrAdTrMqH4LzK6spHfRyUHw0uOJHwyi3aYLPdSuzn6cRecnvpBJQPGq4HkQQ52XD+
	blgZ0qIwBGpxUROHA1NFoO+RiUNA38iFFHkiMazquxgiDfiLBSs6YIS+FENL7lJLh2TDpWKUCmn
	nDRTTy6FUHOZ62zSp95jdw3UdsJyKfowamO5O4aQDDSGU27D4GufVIMvW1Rxw+6+
X-Google-Smtp-Source: AGHT+IGf3ykzqKc9tD5Jfik+cxL+VmgRguw9fPhxZiipI2ssCYUbBdqHAjH6x2OnQLOAWR3dZkWL5g==
X-Received: by 2002:adf:f502:0:b0:3a0:b550:c6f1 with SMTP id ffacd0b85a97d-3a0b550c6f6mr4693056f8f.9.1746703272928;
        Thu, 08 May 2025 04:21:12 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:858e:52f7:3f18:c35c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0adceddb5sm8116628f8f.2.2025.05.08.04.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 04:21:12 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] tools: ynl: handle broken pipe gracefully in CLI
Date: Thu,  8 May 2025 12:21:02 +0100
Message-ID: <20250508112102.63539-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending YNL CLI output into a pipe, closing the pipe causes a
BrokenPipeError. E.g. running the following and quitting less:

./tools/net/ynl/pyynl/cli.py --family rt-link --dump getlink | less
Traceback (most recent call last):
  File "/home/donaldh/net-next/./tools/net/ynl/pyynl/cli.py", line 160, in <module>
    main()
    ~~~~^^
  File "/home/donaldh/net-next/./tools/net/ynl/pyynl/cli.py", line 142, in main
    output(reply)
    ~~~~~~^^^^^^^
  File "/home/donaldh/net-next/./tools/net/ynl/pyynl/cli.py", line 97, in output
    pprint.PrettyPrinter().pprint(msg)
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^
[...]
BrokenPipeError: [Errno 32] Broken pipe

Consolidate the try block for ops and notifications, and gracefully
handle the BrokenPipeError by adding an exception handler to the
consolidated try block.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/cli.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 794e3c7dcc65..33ccc5c1843b 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -144,16 +144,17 @@ def main():
             ops = [ (item[0], json.loads(item[1]), args.flags or []) for item in args.multi ]
             reply = ynl.do_multi(ops)
             output(reply)
-    except NlError as e:
-        print(e)
-        exit(1)
 
-    if args.ntf:
-        try:
+        if args.ntf:
             for msg in ynl.poll_ntf(duration=args.duration):
                 output(msg)
-        except KeyboardInterrupt:
-            pass
+    except NlError as e:
+        print(e)
+        exit(1)
+    except KeyboardInterrupt:
+        pass
+    except BrokenPipeError:
+        pass
 
 
 if __name__ == "__main__":
-- 
2.49.0


